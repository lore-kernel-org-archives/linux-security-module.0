From: jmorris@namei.org (James Morris)
Date: Mon, 28 Aug 2017 13:46:37 +1000 (AEST)
Subject: [PATCH net-next v7 02/10] bpf: Add eBPF program subtype and
	is_valid_subtype() verifier
In-Reply-To: <20170823024452.zvizovwfd7xjucsx@ast-mbp>
References: <20170821000933.13024-1-mic@digikod.net>
	<20170821000933.13024-3-mic@digikod.net>
	<20170823024452.zvizovwfd7xjucsx@ast-mbp>
Message-ID: <alpine.LRH.2.20.1708281345280.8842@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 22 Aug 2017, Alexei Starovoitov wrote:

> more general question: what is the status of security/ bits?
> I'm assuming they still need to be reviewed and explicitly acked by James, right?

Yep, along with other core security developers where possible.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
