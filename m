From: paul@paul-moore.com (Paul Moore)
Date: Mon, 20 Mar 2017 15:30:15 -0400
Subject: out of tree lsm's
In-Reply-To: <CADc-OzFzS0=25zmRQuONzsALck+mV9Q61vSkUOmxWHKdiK_1vQ@mail.gmail.com>
References: <CADc-OzFzS0=25zmRQuONzsALck+mV9Q61vSkUOmxWHKdiK_1vQ@mail.gmail.com>
Message-ID: <CAHC9VhSiEaXYoUhr_Bvs_fLYyA+ex=xQLY26jkPLqivkRpTkqw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Mar 20, 2017 at 2:54 PM, Peter Moody <peter.moody@gmail.com> wrote:
> with the success of stackable lsm's, it occurs to me that
> site-specific, out-of-tree modules could be extremely worthwhile.

Keep in mind we don't have a general purpose solution ... yet.  Casey
continues to work on it, and I'm sure he'll have something at some
point, but right now you are limited to a single "big" LSMs (e.g.
SELinux) and some combination of "small" LSMs (e.g. Yama).

> I realize that it doesn't make a lot of sense to have something that I
> can insmod/rmmod well post-boot, but being able to at least stuff an
> lsm in an initrd that's loaded during boot could be very helpful.
>
> Without having any code to pick apart just now, is the idea of this
> functionality amenable to folks?

I think the usual comments about out-of-tree modules apply here;
you're free to do what you like, but upstream is only going to offer
limited help/support if/until the code starts its way upstream.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
