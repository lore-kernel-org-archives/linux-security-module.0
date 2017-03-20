From: casey@schaufler-ca.com (Casey Schaufler)
Date: Mon, 20 Mar 2017 13:17:27 -0700
Subject: out of tree lsm's
In-Reply-To: <CADc-OzEFBMk1sdbqT54Fwzya2uAAcfFisJ6ZGgxBRJT8s+jzeg@mail.gmail.com>
References: <CADc-OzFzS0=25zmRQuONzsALck+mV9Q61vSkUOmxWHKdiK_1vQ@mail.gmail.com>
	<CAHC9VhSiEaXYoUhr_Bvs_fLYyA+ex=xQLY26jkPLqivkRpTkqw@mail.gmail.com>
	<CADc-OzEFBMk1sdbqT54Fwzya2uAAcfFisJ6ZGgxBRJT8s+jzeg@mail.gmail.com>
Message-ID: <c25cb4fd-9459-1899-8275-beb62d12c265@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 3/20/2017 12:45 PM, Peter Moody wrote:
> On Mon, Mar 20, 2017 at 12:30 PM, Paul Moore <paul@paul-moore.com> wrote:
>> On Mon, Mar 20, 2017 at 2:54 PM, Peter Moody <peter.moody@gmail.com> wrote:
>>> with the success of stackable lsm's, it occurs to me that
>>> site-specific, out-of-tree modules could be extremely worthwhile.
>> Keep in mind we don't have a general purpose solution ... yet.  Casey
>> continues to work on it, and I'm sure he'll have something at some
>> point, but right now you are limited to a single "big" LSMs (e.g.
>> SELinux) and some combination of "small" LSMs (e.g. Yama).

Yes, work is in progress.

> right. sorry for the imprecise language; by site-specific I meant a "small" lsm.
>
> I would love to have the ability write a small lsm that I can build as
> a module and load at boot eg. via initrd.
>
> AIUI, adding even a new "small" lsm requires kconfig patches, building
> a new kernel, etc. I know there are objections to dynamically loadable
> lsms and I was trying to find a compromise that made them easier to
> work with.

The stacking design criteria I'm working with
include not doing anything that would prevent
dynamic module loading. I do not plan to implement
dynamic loading. Tetsuo has been a strong
advocate of loadable modules. I would expect to
see a proposal from him shortly after the
general stacking lands, assuming it does.

>
> Cheers,
> peter
>
>>> I realize that it doesn't make a lot of sense to have something that I
>>> can insmod/rmmod well post-boot, but being able to at least stuff an
>>> lsm in an initrd that's loaded during boot could be very helpful.
>>>
>>> Without having any code to pick apart just now, is the idea of this
>>> functionality amenable to folks?
>> I think the usual comments about out-of-tree modules apply here;
>> you're free to do what you like, but upstream is only going to offer
>> limited help/support if/until the code starts its way upstream.
>>
>> --
>> paul moore
>> www.paul-moore.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
