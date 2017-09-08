From: paul@paul-moore.com (Paul Moore)
Date: Fri, 8 Sep 2017 13:36:29 -0400
Subject: [GIT PULL] Security subsystem updates for 4.14
In-Reply-To: <CA+55aFwMgUJSMQ96XdKnTbn8UsxzHTb8tZQdH40nxDeF7fWObw@mail.gmail.com>
References: <alpine.LRH.2.21.1709041959220.27950@namei.org>
	<CA+55aFw8wgA+jhBOhnY-TSdbPgiYcrFiipCV=rsS1=GQEN+JgQ@mail.gmail.com>
	<alpine.LRH.2.21.1709081448090.7880@namei.org>
	<20170908070943.GA26549@infradead.org>
	<CA+55aFwMgUJSMQ96XdKnTbn8UsxzHTb8tZQdH40nxDeF7fWObw@mail.gmail.com>
Message-ID: <CAHC9VhR2c1rC4--1Br0cx+3eALLdB8Oishw7wwcGwb1_3qN8+w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 8, 2017 at 1:25 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Sep 8, 2017 at 12:09 AM, Christoph Hellwig <hch@infradead.org> wrote:
>>
>> But yes, for the init-time integrity_read_file this is incorrect.
>> It never tripped up, and I explicitly added the lockdep annotations
>> so that anything would show up, and it's been half a year since
>> I sent that first RFC patch..
>
> I don't think anybody actually tests linux-next kernels in any big
> way, and the automated tests that do get run probably don't run with
> any integrity checking enabled.
>
> Which is why I actually look at the code when merging unexpected stuff.
>
> This is also why I tend to prefer getting multiple branches for
> independent things.
>
> Now the whole security pull will be ignored because of this thing. I
> refuse to pull garbage where I notice major fundamental problems in
> code that has obviously never ever been tested.

Is it time to start sending pull request for each LSM and thing under
security/ directly?  I'm not sure I have a strong preference either
way, I just don't want to see the SELinux changes ignored during the
merge window.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
