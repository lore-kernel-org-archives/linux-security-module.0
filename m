From: dhowells@redhat.com (David Howells)
Date: Thu, 09 Nov 2017 17:15:04 +0000
Subject: [PATCH 18/27] bpf: Restrict kernel image access functions when
	the kernel is locked down
In-Reply-To: <20171019233105.5ladqpdf2me36j7q@ast-mbp>
References: <20171019233105.5ladqpdf2me36j7q@ast-mbp>
	<20171019221829.7m5nczg3ltqmhzom@ast-mbp>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842476953.7923.18174368926573855810.stgit@warthog.procyon.org.uk>
	<482.1508453314@warthog.procyon.org.uk>
Message-ID: <13472.1510247704@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > TBH, I've no idea how bpf does anything, so I can't say whether this is
> > better, overkill or insufficient.
> 
> ok. To make it clear:
> Nacked-by: Alexei Starovoitov <ast@kernel.org>
> For the current patch.
> Unnecessary checks for no good reason in performance critical
> functions are not acceptable.

They aren't unnecessary checks.

Can you please suggest if there's some way more suitable than just killing bpf
entirely?  I don't know the code, and I presume you do.

David
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
