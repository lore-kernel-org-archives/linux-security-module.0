From: jmorris@namei.org (James Morris)
Date: Fri, 8 Sep 2017 14:48:51 +1000 (AEST)
Subject: [GIT PULL] Security subsystem updates for 4.14
In-Reply-To: <CA+55aFw8wgA+jhBOhnY-TSdbPgiYcrFiipCV=rsS1=GQEN+JgQ@mail.gmail.com>
References: <alpine.LRH.2.21.1709041959220.27950@namei.org>
	<CA+55aFw8wgA+jhBOhnY-TSdbPgiYcrFiipCV=rsS1=GQEN+JgQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1709081448090.7880@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 7 Sep 2017, Linus Torvalds wrote:

> On Mon, Sep 4, 2017 at 3:29 AM, James Morris <jmorris@namei.org> wrote:
> >
> > IMA:
> >   - A new integrity_read file operation method, avoids races when
> >     calculating file hashes
> 
> Honestly, this seems really odd.
> 
> It documents that it needs to be called with i_rwsem held exclusively,
> and even has a lockdep assert to that effect (well, not really: the
> code claims "exclusive", but the lockdep assert does not), but I'm not
> actually seeing anybody doing it.
> 
> Quite the reverse, I just see integrity_read_file() doing filp_open()
> on the pathname and passing it to integrity_kernel_read() with no
> locking.
> 
> It really looks like just pure garbage to me. I pulled, and I'm not
> unpulling the whole thing. I don't think it's been tested, and I don't
> think it can be right.
> 
> Tell me why I'm wrong, or tell me why that garbage made it in in the
> first place?

Mimi and Christoph worked together on this over several iterations -- I'll 
let them respond.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
