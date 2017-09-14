From: keescook@chromium.org (Kees Cook)
Date: Thu, 14 Sep 2017 14:09:23 -0700
Subject: [GIT PULL] Security subsystem updates for 4.14
In-Reply-To: <alpine.LRH.2.21.1709101419360.22614@namei.org>
References: <alpine.LRH.2.21.1709041959220.27950@namei.org>
	<CA+55aFw8wgA+jhBOhnY-TSdbPgiYcrFiipCV=rsS1=GQEN+JgQ@mail.gmail.com>
	<alpine.LRH.2.21.1709081448090.7880@namei.org>
	<20170908070943.GA26549@infradead.org>
	<CA+55aFwMgUJSMQ96XdKnTbn8UsxzHTb8tZQdH40nxDeF7fWObw@mail.gmail.com>
	<CAHC9VhR2c1rC4--1Br0cx+3eALLdB8Oishw7wwcGwb1_3qN8+w@mail.gmail.com>
	<alpine.LRH.2.21.1709101419360.22614@namei.org>
Message-ID: <CAGXu5jKVU2ecHna5Lb2eoJEHD+e1-sVOkghLdM+DcgG-jN6PcA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Sep 9, 2017 at 9:32 PM, James Morris <jmorris@namei.org> wrote:
> On Fri, 8 Sep 2017, Paul Moore wrote:
>
>> > This is also why I tend to prefer getting multiple branches for
>> > independent things.
>
> [...]
>
>>
>> Is it time to start sending pull request for each LSM and thing under
>> security/ directly?  I'm not sure I have a strong preference either
>> way, I just don't want to see the SELinux changes ignored during the
>> merge window.
>
> They won't be ignored, we just need to get this issue resolved now and
> figure out how to implement multiple branches in the security tree.
>
> Looking at other git repos, the x86 folk have multiple branches.

Yeah, the x86 approach is what inspired my tree layout.

> One option for me would be to publish the trees I pull from as branches
> along side mine, with 'next' being a merge of all of directly applied
> patchsets and those ready for Linus to pull as one.
>
> So, branches in
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
>
> might be:
>
>   next-selinux         (Paul's next branch)
>   next-apparmor   (JJ's next branch)
>   next-integrity  (Mimi's)
>   next-tpm        (Jarkko's)
>   [etc.]
>
>   next                 (merge all of the above to here)
>
> That way, we have a coherent 'next' branch for people to develop against
> and to push to Linus, but he can pull individual branches feeding into it
> if something is broken in one of them.
>
> Does that sound useful?

This is what I do with the KSPP tree (since it has a few unrelated
things in it), but you run the risk of getting too fine-grain and
creating dependencies between trees (e.g. adding a new hook that two
LSMs implement means either they depend on each other or both depend
on some third "core" tree).

How separable are the patches, normally?

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
