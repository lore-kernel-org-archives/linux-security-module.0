From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Wed, 22 Mar 2017 06:53:54 +0900
Subject: out of tree lsm's
In-Reply-To: <864de292-248c-d6fe-c184-95f9964d8f65@schaufler-ca.com>
References: <201703210718.CJE73456.MVHOFFQFLSJOOt@I-love.SAKURA.ne.jp>
	<201703211941.CBC26593.FtOLFQFJSOMOHV@I-love.SAKURA.ne.jp>
	<04d6fd0a-bb59-b3c0-258c-b5826e7277a0@schaufler-ca.com>
	<CADc-OzFAiq4ccLgTYtx+jvkGxduoOC3J+C90UTQWDOB6+EoFfQ@mail.gmail.com>
	<864de292-248c-d6fe-c184-95f9964d8f65@schaufler-ca.com>
Message-ID: <201703220653.EGI86908.VOFOFHOLJtQSMF@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Casey Schaufler wrote:
> On 3/21/2017 9:06 AM, Peter Moody wrote:
> > On Tue, Mar 21, 2017 at 8:36 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> On 3/21/2017 3:41 AM, Tetsuo Handa wrote:
> >>> Tetsuo Handa wrote:
> >>>> Casey Schaufler wrote:
> >>>>>> right. sorry for the imprecise language; by site-specific I meant a "small" lsm.
> >>>>>>
> >>>>>> I would love to have the ability write a small lsm that I can build as
> >>>>>> a module and load at boot eg. via initrd.
> >>>>>>
> >>>>>> AIUI, adding even a new "small" lsm requires kconfig patches, building
> >>>>>> a new kernel, etc. I know there are objections to dynamically loadable
> >>>>>> lsms and I was trying to find a compromise that made them easier to
> >>>>>> work with.
> >>>>> The stacking design criteria I'm working with
> >>>>> include not doing anything that would prevent
> >>>>> dynamic module loading. I do not plan to implement
> >>>>> dynamic loading. Tetsuo has been a strong
> >>>>> advocate of loadable modules. I would expect to
> >>>>> see a proposal from him shortly after the
> >>>>> general stacking lands, assuming it does.
> >>>> But currently __lsm_ro_after_init which is planned to go to 4.12 is preventing
> >>>> dynamic modules from loading. We need a legitimate interface for loadable modules like
> >>>> http://lkml.kernel.org/r/201702152342.GBH04183.FOFJFHQOLMOtVS at I-love.SAKURA.ne.jp .
> >>>> Requiring rodata=0 kernel command line option to allow dynamic modules is silly.
> >>>>
> >>> I think we need something like below change when allowing loadable modules.
> >> I believe that a simpler approach would be to
> >> add a separate list of dynamic hooks to supliment
> >> the list of static hooks. If SELinux unloading is
> >> desired the SELinux hooks would be put on the
> >> dynamic list which would not be "hardened" with
> >> _ro_after_init, where the rest of the static modules
> >> would be.
> > FWIW, I don't know if that would solve the case I was initially asking
> > about since the out-of-tree lsm I was hoping to be able to access all
> > of the standard security hooks with an out-of-tree module.
> 
> It would work fine. All I'm suggesting is that in addition
> to security_hook_heads there would be a
> security_hooks_heads_dynamic. The code in security.c would
> be stretched to loop through both lists. Any locking or
> other complexity associated with being dynamic would be
> limited to the dynamic list.
> 
Yes, adding security_hooks_heads_dynamic would work about calling hooks.
But why not to protect security_hooks_heads_dynamic with mostly-read-only
protection when security_hooks_heads is protected with __ro_after_init?
I don't think SELinux wants to give up read-only protection only for
allowing runtime disable.

And if protecting security_hooks_heads_dynamic, why to use separate lists?
Is keeping security_hooks_heads __ro_after_init a worthwhile protection
when we add a dynamic module to security_hooks_heads_dynamic? A malicious
dynamic module can after all tamper security_hooks_heads by making it
read-write.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
