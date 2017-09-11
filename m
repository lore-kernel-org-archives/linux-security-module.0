From: paul@paul-moore.com (Paul Moore)
Date: Mon, 11 Sep 2017 18:30:53 -0400
Subject: [GIT PULL] Security subsystem updates for 4.14
In-Reply-To: <alpine.LRH.2.21.1709101419360.22614@namei.org>
References: <alpine.LRH.2.21.1709041959220.27950@namei.org>
	<CA+55aFw8wgA+jhBOhnY-TSdbPgiYcrFiipCV=rsS1=GQEN+JgQ@mail.gmail.com>
	<alpine.LRH.2.21.1709081448090.7880@namei.org>
	<20170908070943.GA26549@infradead.org>
	<CA+55aFwMgUJSMQ96XdKnTbn8UsxzHTb8tZQdH40nxDeF7fWObw@mail.gmail.com>
	<CAHC9VhR2c1rC4--1Br0cx+3eALLdB8Oishw7wwcGwb1_3qN8+w@mail.gmail.com>
	<alpine.LRH.2.21.1709101419360.22614@namei.org>
Message-ID: <CAHC9VhRRu2CyeAvh6YA6dQ7Hp_ujjg8dmYE=-wwbfv7nM=dahw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Sep 10, 2017 at 12:32 AM, James Morris <jmorris@namei.org> wrote:
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

Once again, I don't really care too much either way.  My only selfish
motivation is to make it as frictionless as possible to get the
SELinux tree merged into Linus' tree.

> Looking at other git repos, the x86 folk have multiple branches.

I don't really understand what advantage one repo with multiple
branches has over multiple repos, e.g. Linus' just pulling from the
individual LSM trees directly.  I suppose one could make an argument
about linux-next, but I know they prefer to pull from the individual
repos directly (they pull selinux/next directly).  Is it to help
reduce the load on Linus?

>From my perspective, the linux-security tree only introduces another
opportunity for things to go wrong during the merge window (as
evidenced by this latest snafu).  Help me understand why a single tree
with multiple branches is beneficial to multiple trees?

Also, to be clear, I'm not picking on IMA or Mimi; this could have
easily been SELinux screwing things up for IMA (or Smack, or AppArmor,
etc.).

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
>   next-apparmor-next   (JJ's next branch)
>   next-integrity-next  (Mimi's)
>   next-tpm-next        (Jarkko's)
>   [etc.]
>
>   next                 (merge all of the above to here)
>
> That way, we have a coherent 'next' branch for people to develop against
> and to push to Linus, but he can pull individual branches feeding into it
> if something is broken in one of them.
>
> Does that sound useful?

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
