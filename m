Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BDC27B32C;
	Fri, 20 Mar 2026 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773975852; cv=none; b=C1nUTjkLJ10nE+NNWZj8CLyNqAz1zVE8sWYtMlJDkdLJVwQCC8X8R8pyJxo8Mvrwdhvgz1sajrWlewM5fOTxSumR0Wy/1RP+91ul900We7/ldph0P5Z3KkY9OsE/6VwF7ARnVICtaPetTJifTdNfxl3iu2w7VmAC9uQblUrZ+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773975852; c=relaxed/simple;
	bh=eYThT3MbKpFYNcQpTEfUKayeuIaaRPT8BWq2xWByobQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ELbI7naWBzox1H1/uoFKwnBara4MA1be9xPQ836iFjmy3EkRaT6l1tAXgJTJwFyxwGC1B50B1buAAjQpHXc1stdUfnbkN73s94WNdw9exZJUKKscRlTKPZTw+XkBvnXgdIVpAq92NifQyybZy7aps8jU3P0VqWGwfCApK+N/vso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=djaPMawQ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="djaPMawQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ox
	aJO3CSGa1q6/17sHGjrrO6lGYoZ8OGgqhYHb6KeFc=; b=djaPMawQSWjJNkb98J
	FLJLON4fxQioVrz82mwJIpIHAXl51Z2XpJjHmuVAEfcX9lyLc3InsLBi/9claSZo
	uuefl6H7/YBiBy/Vdp9L8c6U4j77x/dsSQ1CB1z4hhDbDuXaSjzYOj+auu3XO7uw
	GHlqj3dNezZvYqjickKw74Q+Y=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDHtXICubxpjsswTQ--.37S2;
	Fri, 20 Mar 2026 11:03:33 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: casey@schaufler-ca.com
Cc: jmorris@namei.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	yangfeng59949@163.com
Subject: Re: [PATCH] lsm: Fix the crash issue in xfrm_decode_session
Date: Fri, 20 Mar 2026 11:03:30 +0800
Message-Id: <20260320030330.82615-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <80ff003b-51fd-4ec8-9505-dfc1c5890ced@schaufler-ca.com>
References: <80ff003b-51fd-4ec8-9505-dfc1c5890ced@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDHtXICubxpjsswTQ--.37S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW7Zw43ZF4rXr43KF15Jwb_yoW8Ww4fpF
	W0gFyvkF1q9FyUKF12k390va1jy34rJry8Jrn8t3yUJ3ZF9r1fWr13uF4Y9a95Kw1UKwsF
	qrW8XF90k3yUZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUbjjDUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbCzwX4cWm8uQVptgAA31

On Thu, 19 Mar 2026 10:51:24 -0700, Casey Schaufler wrote:
> On 3/18/2026 7:22 PM, Feng Yang wrote:
> > On Wed, 18 Mar 2026 10:09:47 -0700, Casey Schaufler wrote:
> >> On 3/17/2026 11:19 PM, Feng Yang wrote:
> >>> From: Feng Yang <yangfeng@kylinos.cn>
> >>>
> >>> After hooking the following BPF program:
> >>> SEC("lsm/xfrm_decode_session")
> >>> int BPF_PROG(lsm_hook_xfrm_decode_session, struct sk_buff *skb, u32 *secid, int ckall)
> >>> {
> >>>     return 1; // Any non-zero value
> >>> }
> >>> Subsequent packet transmission triggers will cause a kernel panic:
> >> LSM hooks that use or provide secids cannot be stacked. That is,
> >> you can't provide a BPF LSM hook and an SELinux LSM hook and expect
> >> correct behavior. Your proposed "fix" removes a legitimate check.
> > I'm very sorry, I didn't quite understand what you meant.
> >
> > Maybe my commit message wasn't clear. I only used a BPF LSM hook without SELinux stacking enabled.
> 
> Do i understand correctly that you do not have SELinux enabled?

Yes.

> 
> > Therefore, is it the expected behavior that simply using
> > SEC("lsm/xfrm_decode_session")
> > int BPF_PROG(lsm_hook_xfrm_decode_session, struct sk_buff *skb, u32 *secid, int ckall) {
> >     return -1;
> > }
> > would cause a kernel panic?
> 
> Yes. As the infrastructure is written, any return other than 0 is erroneous.
> You will need to query the SELinux developers about why they decided to
> implement the xfrm handling in this way.
> 
> >  If not, and if the BUG_ON check is still necessary,
> > then does it mean we need to modify the return value validation logic in the BPF
> > verifier to ensure that only BPF programs returning 0 are accepted for this hook?
> >
> > Thanks.
> >
> >

