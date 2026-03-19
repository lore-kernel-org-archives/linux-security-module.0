Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005B338945A;
	Thu, 19 Mar 2026 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773886965; cv=none; b=csOXaDzX3HwTjpJb7XJBZh26Hfc1d4xZavvVvL34HEvCdKtO9Gj4mb021f375VwQaA8ccyWk4wt4vm2SX1c2Hw6P1L5Q+3SRJZqmmewEYE/k6V4kXzRu5MfwqZAOTpZkGFLnGoeRLnLUG2XMurfuNj7EJmta4rlxPWO7dUOfskM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773886965; c=relaxed/simple;
	bh=CV37AoTuneS5M05EwR9bUlFbk3TwQA6BS1Fdp2h8tDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S+fGENN2Oq9Z3EKGKt5ay2lTj0Pd2iZK0yHFvbODKmOeKspFVUwNsVazO3H3BZYl6eFptU5m/qcjgH2mc2g3v6bFnTJILKzvud8EM6VElxSlhQhiAceKQmEoODPmTy85Nt3w4uEYnH58fdbGxTZZthQR0zDMIxH9IPfx62R6dnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B3SN9grp; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B3SN9grp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=VV
	2aqe0z6bjJwYCTBCy+RAjjstRcVHYa+Vakji3z5QM=; b=B3SN9grp4l/nl51fU8
	jZwByH21PrcGQs+scDarrI67kICpUG95TVgObgHueyyHIK/iBufyHMwT3Uqh4rpF
	54SHR0wfZ6ZZxNY0JamNJb/1Nsty+j4CSq42w0MNXHXxCiJ98AnOVVafQLByEZO3
	a8UFpFE4Um26+HJankS4ycqC0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAHL6bQXbtpoEZmAA--.1740S2;
	Thu, 19 Mar 2026 10:22:10 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: casey@schaufler-ca.com
Cc: jmorris@namei.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	yangfeng59949@163.com
Subject: Re: [PATCH] lsm: Fix the crash issue in xfrm_decode_session
Date: Thu, 19 Mar 2026 10:22:08 +0800
Message-Id: <20260319022208.69924-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <df35542e-d58f-47db-8a4f-92698281a69a@schaufler-ca.com>
References: <df35542e-d58f-47db-8a4f-92698281a69a@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHL6bQXbtpoEZmAA--.1740S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wr43CF48Zw4kGw18Jry5urg_yoW8JrWrpF
	W0grykuFyq9FWjkr4UK398Xa1jy34rGrW8Arn2y34DA3srCrWrWF1a9Fs09a95Gw15K39F
	qF48XFyqkrWUZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUbjjDUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8hLUTWm7XdLx2QAA3M

On Wed, 18 Mar 2026 10:09:47 -0700, Casey Schaufler wrote:
> On 3/17/2026 11:19 PM, Feng Yang wrote:
> > From: Feng Yang <yangfeng@kylinos.cn>
> >
> > After hooking the following BPF program:
> > SEC("lsm/xfrm_decode_session")
> > int BPF_PROG(lsm_hook_xfrm_decode_session, struct sk_buff *skb, u32 *secid, int ckall)
> > {
> >     return 1; // Any non-zero value
> > }
> > Subsequent packet transmission triggers will cause a kernel panic:

> LSM hooks that use or provide secids cannot be stacked. That is,
> you can't provide a BPF LSM hook and an SELinux LSM hook and expect
> correct behavior. Your proposed "fix" removes a legitimate check.

I'm very sorry, I didn't quite understand what you meant.

Maybe my commit message wasn't clear. I only used a BPF LSM hook without SELinux stacking enabled.

Therefore, is it the expected behavior that simply using
SEC("lsm/xfrm_decode_session")
int BPF_PROG(lsm_hook_xfrm_decode_session, struct sk_buff *skb, u32 *secid, int ckall) {
    return -1;
}
would cause a kernel panic? If not, and if the BUG_ON check is still necessary,
then does it mean we need to modify the return value validation logic in the BPF
verifier to ensure that only BPF programs returning 0 are accepted for this hook?

Thanks.

