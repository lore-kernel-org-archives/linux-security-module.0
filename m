From: peter.moody@gmail.com (Peter Moody)
Date: Mon, 20 Mar 2017 11:54:26 -0700
Subject: out of tree lsm's
Message-ID: <CADc-OzFzS0=25zmRQuONzsALck+mV9Q61vSkUOmxWHKdiK_1vQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

with the success of stackable lsm's, it occurs to me that
site-specific, out-of-tree modules could be extremely worthwhile.

I realize that it doesn't make a lot of sense to have something that I
can insmod/rmmod well post-boot, but being able to at least stuff an
lsm in an initrd that's loaded during boot could be very helpful.

Without having any code to pick apart just now, is the idea of this
functionality amenable to folks?

Cheers,
peter
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
