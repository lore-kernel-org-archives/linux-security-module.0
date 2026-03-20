Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB4A13959D
	for <linux-security-module@vger.kernel.org>; Fri, 20 Mar 2026 03:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773976838; cv=none; b=ijd3hqg0Y/A3ZDOmal9GNHx3Cnrblyi5XE2HQ87kr5WyI3cN5X+ROZl1kjsWOlgwGC1cQ1295vsOrLGn/8uG5hNIIvN29rDyAVdOKkT9qLLdI2NHz8j3x84Odna0SHqoaL7JUAs+VGgD6x8xa7QhGL8keenSNFjCBEJsPyzpZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773976838; c=relaxed/simple;
	bh=sxwMTxsCuRnjEj3f/aZ8vHtZng2xp3aaUqmpOjNSWr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hx1qkEoK07aHNEO6ijnwbXw41UmT3AN2xHyBLGRSMUtcnPO26QJ9zzGaaJvXT03lFZDqL39yaz9ofhN4oxo+Ack7zIQpyHGeoczLz1/F2xSUOAC5cbZLDVyN2sufSX2woy9cgV6UFYb8YdoeTGMS20DDPFCTaoIJGcyKM9+xe+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oiwYjylS; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oiwYjylS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3+
	xvXTdRC2vAVQOa+c/PAQ7xBiqxiKZbebpThNBsHdA=; b=oiwYjylSaoBRV9ezCp
	fIhJ/CzRcSZxtUYoAjRX1GC09UOuQ3m7lJ3EPY1zvKpeBXYo7ltzgMv3DWtiFkbt
	S6PFLEoSbTSBu3zJ/KunP/8HovB82vtgsk0dZ6q2g4QjdYGpGo4g+C6RlLvhwtQm
	RlIQs2r+vc/ulQvQAYuwECleE=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3v8v3vLxpjkXgSw--.145S2;
	Fri, 20 Mar 2026 11:20:26 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: stephen.smalley.work@gmail.com,
	casey@schaufler-ca.com,
	jmorris@namei.org--to=paul@paul-moore.com--to=serge@hallyn.com--cc=linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	yangfeng59949@163.com
Subject: Re: [PATCH] lsm: Fix the crash issue in xfrm_decode_session
Date: Fri, 20 Mar 2026 11:20:22 +0800
Message-Id: <20260320032022.87651-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAEjxPJ5aA01in+Z1yLF1cwe-3uqL_E8SKGK4J294D5eRG5__5Q@mail.gmail.com>
References: <CAEjxPJ5aA01in+Z1yLF1cwe-3uqL_E8SKGK4J294D5eRG5__5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD3v8v3vLxpjkXgSw--.145S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF4rAF43Aw4kKw43Aw45trb_yoWrJF18pF
	4jkFWvkr4DCF1jkFs2krWYg34Yv34fGry8JryDK3y3A34q9r1rWFsI9r4a9a93Cw48Ka1a
	qr48XFZ8urWUAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR3PExUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC0Bv2b2m8vPu+hQAA37

On Thu, 19 Mar 2026 14:22:06 -0400, Stephen Smalley wrote:
> On Thu, Mar 19, 2026 at 1:52 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > On 3/18/2026 7:22 PM, Feng Yang wrote:
> > > On Wed, 18 Mar 2026 10:09:47 -0700, Casey Schaufler wrote:
> > >> On 3/17/2026 11:19 PM, Feng Yang wrote:
> > >>> From: Feng Yang <yangfeng@kylinos.cn>
> > >>>
> > >>> After hooking the following BPF program:
> > >>> SEC("lsm/xfrm_decode_session")
> > >>> int BPF_PROG(lsm_hook_xfrm_decode_session, struct sk_buff *skb, u32 *secid, int ckall)
> > >>> {
> > >>>     return 1; // Any non-zero value
> > >>> }
> > >>> Subsequent packet transmission triggers will cause a kernel panic:
> > >> LSM hooks that use or provide secids cannot be stacked. That is,
> > >> you can't provide a BPF LSM hook and an SELinux LSM hook and expect
> > >> correct behavior. Your proposed "fix" removes a legitimate check.
> > > I'm very sorry, I didn't quite understand what you meant.
> > >
> > > Maybe my commit message wasn't clear. I only used a BPF LSM hook without SELinux stacking enabled.
> >
> > Do i understand correctly that you do not have SELinux enabled?
> >
> > > Therefore, is it the expected behavior that simply using
> > > SEC("lsm/xfrm_decode_session")
> > > int BPF_PROG(lsm_hook_xfrm_decode_session, struct sk_buff *skb, u32 *secid, int ckall) {
> > >     return -1;
> > > }
> > > would cause a kernel panic?
> >
> > Yes. As the infrastructure is written, any return other than 0 is erroneous.
> > You will need to query the SELinux developers about why they decided to
> > implement the xfrm handling in this way.
> 
> Looks like this BUG_ON() has just been preserved since first being
> introduced by:
> https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=beb8d13bed80f8388f1a9a107d07ddd342e627e8

Yes, there is a comment in https://lore.kernel.org/all/Pine.LNX.4.64.0607122149070.573@d.namei/:

	+static inline void security_xfrm_skb_secid(struct sk_buff *skb, u32 *secid)
	{
	-	return security_ops->xfrm_decode_session(skb, fl);
	+	BUG_ON(security_ops->xfrm_decode_session(skb, secid, 0));

	BUG_ON looks wrong here, in that you don't know why the LSM returned an 
	error, and why should the box panic at this point at all?

But it seems no one has answered this question before.

> I think we can remove it at this point - it evidently doesn't ever
> trigger for SELinux or we would have seen it by now and it is
> definitely unsafe for BPF LSM.

Yes, the call in the SELinux module is as follows.

void security_skb_classify_flow(struct sk_buff *skb, struct flowi_common *flic)
{
	int rc = call_int_hook(xfrm_decode_session, skb, &flic->flowic_secid,
			       0);

	BUG_ON(rc);
}

int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall)
{
	if (skb == NULL) {
		*sid = SECSID_NULL;
		return 0;
	}
	return selinux_xfrm_skb_sid_ingress(skb, sid, ckall);
}

static int selinux_xfrm_skb_sid_ingress(struct sk_buff *skb,
					u32 *sid, int ckall)
{
	u32 sid_session = SECSID_NULL;
	struct sec_path *sp = skb_sec_path(skb);

	if (sp) {
		int i;

		for (i = sp->len - 1; i >= 0; i--) {
			struct xfrm_state *x = sp->xvec[i];
			if (selinux_authorizable_xfrm(x)) {
				struct xfrm_sec_ctx *ctx = x->security;

				if (sid_session == SECSID_NULL) {
					sid_session = ctx->ctx_sid;
					if (!ckall)
						goto out;
				} else if (sid_session != ctx->ctx_sid) {
					*sid = SECSID_NULL;
					return -EINVAL;
				}
			}
		}
	}

out:
	*sid = sid_session;
	return 0;
}

Since ckall is 0, selinux_xfrm_skb_sid_ingress will only return 0.
Therefore, the selinux_xfrm_decode_session function will only return 0 when ckall is 0, and BUG_ON will never be triggered.

However, BPF can be exploited to cause a system crash.

