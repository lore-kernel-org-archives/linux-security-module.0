From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Sun, 9 Sep 2018 00:58:43 +0900
Subject: next-20180906 crashes during ubifs_mount (legacy fs_context)
In-Reply-To: <20180908131312.eob2glzykvq5w7dd@viti.kaiser.cx>
References: <20180908131312.eob2glzykvq5w7dd@viti.kaiser.cx>
Message-ID: <d3fffb0f-5a7d-aa9c-cdfd-6cafc38f8cc6@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Got response from David Howells to a mail I forwarded...

-------- Forwarded Message --------
From: David Howells <dhowells@redhat.com>
In-Reply-To: <62a743d3-80af-8586-8719-e17a224de62f@I-love.SAKURA.ne.jp>
References: <62a743d3-80af-8586-8719-e17a224de62f@I-love.SAKURA.ne.jp> <20180908131312.eob2glzykvq5w7dd@viti.kaiser.cx>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: dhowells at redhat.com, Martin Kaiser <lists@kaiser.cx>
Subject: Re: Fwd: next-20180906 crashes during ubifs_mount (legacy fs_context)
Date: Sat, 08 Sep 2018 16:19:08 +0100
Message-ID: <10870.1536419948@warthog.procyon.org.uk>

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:

> I have CONFIG_SECURITY disabled. Enabling it does not change the behaviour.
> 
> Commenting out the -ENOPARAM check makes the mount work again.
> 
> I'm not sure how to fix this.  Is it ok for
> security_fs_context_parse_param() to return 0 when CONFIG_SECURITY is turned
> off? Shouldn't this be -ENOPARAM, meaning "not a parameter I care about"?

Yes.  The default should be -ENOPARAM, both in security.c and security.h.

I've fixed my tree and Al has pulled it, but it won't get into linux-next
until Stephen next refreshes it.

David
