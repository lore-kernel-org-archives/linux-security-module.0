From: peter.moody@gmail.com (Peter Moody)
Date: Tue, 21 Mar 2017 09:06:53 -0700
Subject: out of tree lsm's
In-Reply-To: <04d6fd0a-bb59-b3c0-258c-b5826e7277a0@schaufler-ca.com>
References: <CADc-OzFzS0=25zmRQuONzsALck+mV9Q61vSkUOmxWHKdiK_1vQ@mail.gmail.com>
	<CAHC9VhSiEaXYoUhr_Bvs_fLYyA+ex=xQLY26jkPLqivkRpTkqw@mail.gmail.com>
	<CADc-OzEFBMk1sdbqT54Fwzya2uAAcfFisJ6ZGgxBRJT8s+jzeg@mail.gmail.com>
	<c25cb4fd-9459-1899-8275-beb62d12c265@schaufler-ca.com>
	<201703210718.CJE73456.MVHOFFQFLSJOOt@I-love.SAKURA.ne.jp>
	<201703211941.CBC26593.FtOLFQFJSOMOHV@I-love.SAKURA.ne.jp>
	<04d6fd0a-bb59-b3c0-258c-b5826e7277a0@schaufler-ca.com>
Message-ID: <CADc-OzFAiq4ccLgTYtx+jvkGxduoOC3J+C90UTQWDOB6+EoFfQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Mar 21, 2017 at 8:36 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 3/21/2017 3:41 AM, Tetsuo Handa wrote:
>> Tetsuo Handa wrote:
>>> Casey Schaufler wrote:
>>>>> right. sorry for the imprecise language; by site-specific I meant a "small" lsm.
>>>>>
>>>>> I would love to have the ability write a small lsm that I can build as
>>>>> a module and load at boot eg. via initrd.
>>>>>
>>>>> AIUI, adding even a new "small" lsm requires kconfig patches, building
>>>>> a new kernel, etc. I know there are objections to dynamically loadable
>>>>> lsms and I was trying to find a compromise that made them easier to
>>>>> work with.
>>>> The stacking design criteria I'm working with
>>>> include not doing anything that would prevent
>>>> dynamic module loading. I do not plan to implement
>>>> dynamic loading. Tetsuo has been a strong
>>>> advocate of loadable modules. I would expect to
>>>> see a proposal from him shortly after the
>>>> general stacking lands, assuming it does.
>>> But currently __lsm_ro_after_init which is planned to go to 4.12 is preventing
>>> dynamic modules from loading. We need a legitimate interface for loadable modules like
>>> http://lkml.kernel.org/r/201702152342.GBH04183.FOFJFHQOLMOtVS at I-love.SAKURA.ne.jp .
>>> Requiring rodata=0 kernel command line option to allow dynamic modules is silly.
>>>
>> I think we need something like below change when allowing loadable modules.
>
> I believe that a simpler approach would be to
> add a separate list of dynamic hooks to supliment
> the list of static hooks. If SELinux unloading is
> desired the SELinux hooks would be put on the
> dynamic list which would not be "hardened" with
> _ro_after_init, where the rest of the static modules
> would be.

FWIW, I don't know if that would solve the case I was initially asking
about since the out-of-tree lsm I was hoping to be able to access all
of the standard security hooks with an out-of-tree module.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
