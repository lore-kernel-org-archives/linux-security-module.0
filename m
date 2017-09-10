From: jmorris@namei.org (James Morris)
Date: Sun, 10 Sep 2017 12:08:49 +1000 (AEST)
Subject: [GIT PULL] Security subsystem updates for 4.14
In-Reply-To: <20170908223806.7yv6eohtsispwgas@thunk.org>
References: <alpine.LRH.2.21.1709041959220.27950@namei.org>
	<CA+55aFw8wgA+jhBOhnY-TSdbPgiYcrFiipCV=rsS1=GQEN+JgQ@mail.gmail.com>
	<alpine.LRH.2.21.1709081448090.7880@namei.org>
	<20170908223806.7yv6eohtsispwgas@thunk.org>
Message-ID: <alpine.LRH.2.21.1709101205500.13364@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 8 Sep 2017, Theodore Ts'o wrote:

> On Fri, Sep 08, 2017 at 02:48:51PM +1000, James Morris wrote:
> > 
> > Mimi and Christoph worked together on this over several iterations -- I'll 
> > let them respond.
> 
> Mimi --- we should chat next week in LA.  I've been working on a
> design internally at work which proposes a generic VFS-layer library
> (ala how fscrypt in fs/crypto works) which provides data integrity
> using per-file Merkle trees.

It's possible we could add a BoF at LSS on the Thursday (from 5:45pm), or 
even Friday afternoon:

http://events.linuxfoundation.org/events/linux-security-summit/program/schedule

Let me know if you want to schedule something.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
