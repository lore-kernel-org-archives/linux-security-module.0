From: dave@stgolabs.net (Davidlohr Bueso)
Date: Wed, 28 Mar 2018 16:20:29 -0700
Subject: [REVIEW][PATCH 01/11] sem/security: Pass kern_ipc_perm not
	sem_array into the sem security hooks
In-Reply-To: <bdf6ed62-b75c-1920-d5ce-ea08428d03d0@schaufler-ca.com>
References: <87vadmobdw.fsf_-_@xmission.com>
	<20180323191614.32489-1-ebiederm@xmission.com>
	<bdf6ed62-b75c-1920-d5ce-ea08428d03d0@schaufler-ca.com>
Message-ID: <20180328232029.k47nocmmahtxqmg2@linux-n805>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 23 Mar 2018, Casey Schaufler wrote:

>A kern_ipc_perm pointer is conventionally named isp in this code.

So the ideal name would be ipcp, used in core ipc, but I have no strong
preference over isp, ipp or whatever other name is used in LSMs. The
important thing is that kern_ipc_perm should not be called sma or any
ipc specific name.

>How about instead:

Agreed.

>
>-static int smack_sem_alloc_security(struct sem_array *sma)
>+static int smack_sem_alloc_security(struct kern_ipc_perm *isp)
> {
>-	struct kern_ipc_perm *isp = &sma->sem_perm;
>

Thanks,
Davidlohr
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
