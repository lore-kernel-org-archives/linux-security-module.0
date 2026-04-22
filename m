Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F85125A2C6;
	Wed, 22 Apr 2026 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776840007; cv=none; b=h10aFj5qTuwd+/JYCQdvZoS6OGYNqzL0suWQxINzxgEmWRbazSRsb8oD96xR9cLsZF/44tib3VLDzvBEnbJC33vQeIcLNrTVaMgKyO1pUlsnhVBQoN6DGz2dUkqbqYBQrzKRmYCUiYWCVBeQabpoGzj6dsyXUq3MKhAEY8LyL2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776840007; c=relaxed/simple;
	bh=RnfofKspOELHY02wSoIXTk/PJe1IafVqJ+j5hlyaJ3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ValUJuAfCqZ9SWdpiT2723BFLsJFymkg/aI7M1zwTU3wLyiS8DW3U6noKxbqM21dicIPi4WReN03UJmSU7xkURWxFscU7o3wg2mjlBQGkJci1uombLkhYcQqH5Z+RGCdYWTtEyX6MGpesVXGePPrf7so8kgUPp1ClxM+iScJxSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=agt7q7jy; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="agt7q7jy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vg
	Qye6P1g0DkmW/K5zwajOXqPlzvEiieix/ksAY8TvI=; b=agt7q7jyh6SECOlqN3
	uflK9/nuwbpzcQ2mXt0FQVMC8OSUboO3KB5Bl+eZTuaA6wPFoHikq8mQ8AE6iC4G
	f2hCp/5Yd6sFeeWfcr7g7SEF5XBHGYus2RftBCCExdjGLczlV5k1TfSCMd1uhpjC
	fRl+jAKartkLKqr/CO0uX1LwM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wA3i5YabehpD8VLBA--.57647S2;
	Wed, 22 Apr 2026 14:39:24 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: stephen.smalley.work@gmail.com
Cc: jmorris@namei.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com,
	yangfeng59949@163.com
Subject: Re: [PATCH] lsm: Fix the crash issue in xfrm_decode_session
Date: Wed, 22 Apr 2026 14:39:21 +0800
Message-Id: <20260422063921.168259-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAEjxPJ6jPh9_P=56VfAhGQG-Y=njosFuV_Kys9kzhkm7PxRPLg@mail.gmail.com>
References: <CAEjxPJ6jPh9_P=56VfAhGQG-Y=njosFuV_Kys9kzhkm7PxRPLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3i5YabehpD8VLBA--.57647S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF45CF4fKF1kAF1fJF1fZwb_yoW8ury8pr
	4xKFyjka98GFyxurn2yFsI9F1Sy3y5GF15Jr4ayw1UAFyqvr15KF1akw4j93s3Cr45C340
	yr13ZFsxGF1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUbjjDUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8R32b2nobR2ZLwAA3y

On Mon, 13 Apr 2026 13:39:18 -0400, Stephen Smalley wrote:

[...]
> > This BUG_ON was first mentioned in [1], but I could not find any explanatory record of why this check is needed.
> >
> > [1] https://lore.kernel.org/all/Pine.LNX.4.64.0607122149070.573@d.namei/
> >
> > In the existing LSM_HOOK_INIT(xfrm_decode_session, selinux_xfrm_decode_session),
> > when the `ckall` parameter of the `selinux_xfrm_decode_session` function is 0,
> > it can only return 0 and will not trigger BUG_ON.
> > Therefore, remove the BUG_ON check to fix this issue.
> >
> > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > Closes: https://lore.kernel.org/all/4c4d04ba.6c12b.19c039b69e6.Coremail.kaiyanm@hust.edu.cn/
> > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> 
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> 
> With the proviso that we likely ought to follow up with a clean-up
> that introduces a separate skb_classify_flow LSM hook that returns
> void so we don't awkwardly ignore errors below and defer handling to
> the individual security module.

Thank you for your review. Should the follow-up cleanup optimization for
adding a separate skb_classify_flow hook be submitted after this patch is merged?

> > ---
> >  security/security.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/security/security.c b/security/security.c
> > index 67af9228c4e9..198f650070da 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -4991,10 +4991,7 @@ int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
> >
> >  void security_skb_classify_flow(struct sk_buff *skb, struct flowi_common *flic)
> >  {
> > -       int rc = call_int_hook(xfrm_decode_session, skb, &flic->flowic_secid,
> > -                              0);
> > -
> > -       BUG_ON(rc);
> > +       call_int_hook(xfrm_decode_session, skb, &flic->flowic_secid, 0);
> >  }
> >  EXPORT_SYMBOL(security_skb_classify_flow);
> >  #endif /* CONFIG_SECURITY_NETWORK_XFRM */
> > --
> > 2.43.0

