Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD03EA97E
	for <linux-security-module@vger.kernel.org>; Thu,  1 Oct 2026 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790853920; cv=none; b=DSa3PEcxW9+9VL6+Pb0VqEYSfHIZIf0WwAeBFo2m6QdBEyn/BiDIj+0GhtB2LW+aP13HLlgq2C8Lye5l98RALudeTeoQKo5l6Xyk/m1XFUCU+1Ve2tdOtMI82Q5O6GNzBR+JqcYABtG8lxuwpivOYa4+yh7QYL/XGPTchtSkHPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790853920; c=relaxed/simple;
	bh=9CGqo3j/H8jtsytG/iBHkkrKfhSBlsLF/G0jzVlzdjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xp0/hl1L8gBnlmFodDAK1YrDxHv/aXoFHtYH6OUS7eXOueSWNaSOluvKKBSwOfx2rAkIMhQfxH4/Vxs1jJYRM4qRiR61a879zGlLASgnUkTR8zXPCOnrovLxG+zUlLXNS5QgJMv7xeHlulVRnl+0FFD7l5FEgpt7JHcdHkQ/svc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qyPVxPCo; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyPVxPCo"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f01363so38769185ad.2
        for <linux-security-module@vger.kernel.org>; Thu, 01 Oct 2026 04:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790853919; x=1791458719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+bBhxMRT/vov0B/S9wM45+cLW9zsvkTmF1NV6KSNFOo=;
        b=qyPVxPConaxEWzx0tt17muVZsDyThQYCkMTZIQfmp/B7S3uHkkNkWHoLEkqHy9bqeq
         jLhIQdSoPnIFZnNBqHFba3UKrz7/PTqisWfCS7qj18hh38qmMhqGKMDtiUIGS6/qptAk
         qGrkaXsxkieJnsnUgx2/TfqB/UrWIOtnzIWN/SqS5aWBYCmV/RB9e6XdagqdM07JTM3M
         BISYehH3na8Dq3bD8bjGDDzSEQAC4ksStXOlHJm7ZFAsPU07ntIinyo28S/l7qDLr4An
         q8dfp9nC4wYHFqPHiNciVHP1WYnM0hiOwnQf+KpX0T5PyKh01DGR8uLkFikHO1+Z6u5H
         clKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790853919; x=1791458719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+bBhxMRT/vov0B/S9wM45+cLW9zsvkTmF1NV6KSNFOo=;
        b=NW9rkFMkh/42HGqR9WsTCSrdWRFaDi8GM0tehN0G4jNTDag8UH3u4V/ezbUvVy9jfL
         SDJIT88+dvXfO39hQV9+RxQEs7FRUesbQtIXjQy0+iavs8yT6wNiI7rp8itKr+yGnSIc
         tx48d5j4ooLld+CWHa4EcLFTLAxUOe8rnmAurApTKJdZJAZ9L/IyxyEOWDtC6aaQzbJr
         WMa4J8sT9z9B1u0iUTlEztROf6ISUU/sHrtO6qyAwGzCQ8jLmBOG/iQ3e7jJZ6LNqDMq
         tKe2tvGCassGDoo7dwGSyILGpf+puPcwhvYQg7LFKyd2lF3m3vF34Snh6lPuth/PlT3S
         8wOA==
X-Gm-Message-State: AFq9FYKk/thI+BXxiKZMF5nRPDfYAnr2itlPrVmlyB9j7XZhxzis/9R4
	kWrWp67c2qiLZG38nEh2EtMkQ8JbuV1Y3hZ8KWh7pALSuUN+I68leTn3ZXXgptvzgI4=
X-Gm-Gg: AYBFou0Htwt2abM6Mawj35Qlz3p25fn/1lDM+iwpDPXw1QI7iWOOcRpprXgs/GcpsJY
	n4TjbvpZT/qcbd31rL/pQT52rDNHVcILfCIDF8i5G9ysU54vUy6wnHxh7s86q8GwWncBvq60RFk
	x1HIip0ahhUaCacag1HeQCPYEBrBW65zUDXpFKQOFCfjfLM2k2234r40811NWYn1lWBYcjqRpDj
	jC0I6VQcZbijBnS+8jK3MVFA+AcPX+9aRdGbhkfRnRiL4+UzwDlBfmziDEY4sMdlZCMvpvdfwX3
	WvutATIAOUbrGUTFles3xcAwUsQzXO9ewe7HGDhw017GdN/aS/8ChOjQtGB0W1S3Z5ilndMrCYf
	xhqUwbdYoSDUzvU9vXJPKM+3Trl+TIovbl7coBI9AbXaO0X3RgMjo7Z1su8XhbWoHsICYT850cE
	i57nHhPWSQGornbRqtENsObu3MWFP6rpvHPddmOpyTlBn5A2yVPQbTVxJmLkNZ1EEf1XOH/iyhD
	DZ79yenmafgzt2IeJ5DtvH2ov9blGg+EMf/Tg1cPsuS2OKfRUm8GYj/K71Oll03mSj8dFzGWvj6
	Xy2+TOzTlHyGHc+NuLqzFHIATDzRgOpqK37CH5Qq7rpQnbimx7TJb8Kb3Tw=
X-Received: by 2002:a17:902:f644:b0:2e2:da27:a926 with SMTP id d9443c01a7336-2e2e48ae836mr35140875ad.1.1790853918504;
        Thu, 01 Oct 2026 04:25:18 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300b5a45bsm9026825ad.69.2026.10.01.04.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 04:25:18 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Fan Wu <wufan@kernel.org>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: name the wufan/ipe next branch
Date: Thu,  1 Oct 2026 19:25:15 +0800
Message-ID: <20261001112515.3822457-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <9699317a-df42-4ae0-986c-5602e66ae773@kernel.org>
References: <20260926055223.3678216-1-matthias.goergens@gmail.com> <9699317a-df42-4ae0-986c-5602e66ae773@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Fan,

> I also looked at your Sashiko PR. When the default HEAD is a strict
> ancestor of Linus' master, would Sashiko use Linus' master instead?
> If so, that's the behavior we want for IPE, and there would be no
> need to add next here.

Yes, nearly: since 28 September Sashiko skips such a HEAD and tries
linux-next first, then Linus' master.  linux-next is Linus' master plus
what is queued, so a patch based on master applies there unless it
conflicts with something queued, and then it falls back to master.
Either way it no longer reviews against a stale ipe master.  So please
drop this patch.

Thanks,
Matthias
