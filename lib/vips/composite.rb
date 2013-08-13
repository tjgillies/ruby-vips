require 'set'
module VIPS

    class Image
        # make a constant image, the same size and format as this image
        def const(c)
            # make a one pixel image of the correct format and value
            onepx = Image::black(x_size, y_size, 1).lin(1, c).clip2fmt(band_fmt)
    
            # and enlarge to the size of this image
            onepx.embed :extend, 0, 0, x_size, y_size
        end
    
        # get the 'interpretation' metadata item
        def interpretation
            {
                10 => :histogram,
                12 => :xyz,
                13 => :lab,
                15 => :cmyk,
                16 => :labq,
                18 => :ucs,
                19 => :lch,
                21 => :labs,
                22 => :srgb,
                23 => :yxy,
                24 => :fourier,
                25 => :rgb16,
                26 => :grey16
            }[get('interpretation')]
        end
    
        # does an image have an alpha channel
        # four-band images do, unless they are CMYKs
        def alpha?
            bands == 2 or 
                (bands == 4 and interpretation != :cmyk) or 
                (bands == 5 and interpretation == :cmyk)
        end
    
        # get the alpha band -- if there isn't one, make it
        def get_alpha
            if alpha?
                extract_band bands - 1
            else
                # make a 255 (opaque) alpha for it
                const 255
            end
        end
    
        # add an alpha, if there isn't one there now
        def add_alpha
            if alpha?
                self
            else
                bandjoin get_alpha
            end
        end
    
        # get the image (ie. non-alpha) bands
        def get_image
            if alpha?
                extract_band 0, bands - 1
            else
                self
            end
        end
    
        # composite two images with optional alpha channels
        def composite(other_image, x, y, mode)
            # if other_image has no alpha, we can just paste it straight in, no
            # compositing required
            if not other_image.alpha?
                if alpha?
                    return insert_noexpand other_image.add_alpha, x, y
                else
                    return insert_noexpand other_image, x, y
                end
            end
    
            # we need to composite -- pull out the area we will be overlaying, 
            # blend the two images and the two alpha channels, paste back again
    
            # we need to find the rect common to both images

            h = Set.new(0 ... x_size).intersection(Set.new(x ... (x + other_image.x_size)))
            v = Set.new(0 ... y_size).intersection(Set.new(y ... (y + other_image.y_size)))
    
            # no overlap ... other_image is not visible, just return the 
            # background
            if h.empty? or v.empty?
                return self
            end
    
            bg = extract_area h.first, v.first, h.length, v.length 
            fg = other_image.extract_area h.first - x, v.first - y, h.length, v.length 
            a1 = fg.get_alpha.lin(1.0 / 255.0, 0)
            a2 = bg.get_alpha.lin(1.0 / 255.0, 0)
    
            c1 = fg.get_image
            c2 = bg.get_image
    
            case mode
            when :over
                a = a1 + a2 * a1.lin(-1, 1)
                c = (c1 * a1 + c2 * a2 * a1.lin(-1, 1)) / a
    
            else
                raise "bad compositing mode"
            end
    
            a = a.lin(255.0, 0).clip2fmt(:uchar)
            c = c.clip2fmt(band_fmt)
    
            if alpha?
                insert_noexpand c.bandjoin(a), h.first, v.first
            else
                insert_noexpand c, h.first, v.first
            end
        end
    end
end
