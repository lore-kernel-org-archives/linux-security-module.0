Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FDC282F04
	for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525648; cv=pass; b=PZqFOUjEJTrSGUoBfeq146ladGmybqASg/ovWSnJ5wWy+7CWTE1wyRVhiw1rNvDIrifsTwdHpAYwFu/gvwCDiwl45GI9ZSSz0lpudiMzni4Ax6awjX0GiqkRgIxafLPEr9WqKjckPhqolUBRG+zHIz7G1RT2jii4nydNLB2DWRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525648; c=relaxed/simple;
	bh=+OC/aOVSLfYfpueSMiZtB05tveFOE9PwUOUI1E84v54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsck+5W5z7oXar+lX+b1fuIEdZEECfbrb5ESUgZHmrIl3RuPppYwTIoer6bhNFmDFj9c/3QQiyikhEgXaXSFPUFa1ZjbqdaqB7XIp+0QSt8FhH4T7HZFsiPDnhukm03ahpmbR0JNleMcGXvCmJ7dxapS0rqmXllp883lHVhUxMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iX5T41zx; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX5T41zx"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45e8a834cc2so4058431f8f.1
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 01:40:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779525646; cv=none;
        d=google.com; s=arc-20240605;
        b=lXIvIaE4GtBMnOS56hnKcLRTmilnhin0OiIfkOJ7eCE6W4UwT+f8tu+IEOHO7O3wZF
         DsrJxeXKL5dJP99ezmcpK21Ig8X+aZNmzRE2YTawdy2OMOXxQo8pvbW7nyMBvFyD3JNj
         w0n3wJeRR6WnhcHwds2lv5P9ItMajLgMghv1YdJRZkkS0FCSBUtzk/03rMCTovN0bXDT
         TNQYCCEw5Peh9Cwg/PDT0dPIsv2YbvRl0K6jDfE/hRk2FIR9dYLq+qwsVgtysMuVbp9c
         4o8Uuyzn34ZAMgAZNm+Sy9VMFt4SnLZBErYzql26cRgJKPLksUj5fMs71zQxefQqWuNV
         eKzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+OC/aOVSLfYfpueSMiZtB05tveFOE9PwUOUI1E84v54=;
        fh=q4Gz044ygDWT4+6hBcI3+pHvox88UqOA6J86NyOhurc=;
        b=Hpu82yNC5Qa3Lnp0nUKa53Vs6Ax0k0ePhCa1aqCTK+d8vbNVEJEB7WfhRJWLOgKkLz
         bp6of/1Mr7/zS96mDcc79qC8KSo5Ff2n/21ot55V3AedfLbcgSf9m0n2Vebidl4e3jpg
         crtbdr5cP3aEhI8kUgVISzyHpEsqTC+rMSbG9FjUxyyZRXdbEXAIGpWU7oByyttTbgyX
         rTs4IhLhHj1MQp7/Cj9KfAj0pP77YWWVhgRn3Dfh3Qa3OQItPJMFAJk9HixMJPhnnRMJ
         tFCuMIXH0gf4yV7rrNoAdxMfuBIRkWJDq9QSxAn9ZavjqtaZqb0d4NcHM229oaFCuAjY
         EEBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779525646; x=1780130446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OC/aOVSLfYfpueSMiZtB05tveFOE9PwUOUI1E84v54=;
        b=iX5T41zxD9fuAykofZGOW/O5jpmj9Y2yiJa9GmubSCqOE2tkQFrNafvstH6zR1HVjY
         Z7gX49xSskaElWouNewMj+YvD7sqsNHhX5sdBcSqYd+8el5mo/LFJYmWL2S26me1cBaF
         tgNNwGe8FJlt0TW477pr+7cpniW5vMYafPVH+TFnJZ0/dXIignFXdfAiFKUQfzRczD+D
         66RgIUgnsK6SOqL8DwVGXr/LtVapJz0qWX7IGNhgcgNxfaZfv1bdGyNdHoAbomUbayQ5
         CQIT06phdclys79C+j3G/GjSwmk+Zp3EXnxaoXohcu85qyDV7ha7Xn2g1rNR7mAaW9FV
         P46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525646; x=1780130446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+OC/aOVSLfYfpueSMiZtB05tveFOE9PwUOUI1E84v54=;
        b=gADq8RsMFLkGfmDnEBXznpJ2/9as5WqI/ykM0ngoQWuQQBuRxrAfQaHSvLJr7YxXp4
         EpqfEbS/M38qKrpMRhk1aRapu8dan25gxmUN1hk5j2oiDWu4NMXNXAVL405UeDW2vWLK
         GLblSe/5TvqU7t8YtieJXSPyApOmF1KIr1eBJUMRx+XPBrVttFVGXInZiCa1N8Km9bot
         th4TODlz6LRppEWgrUux/2Ycg+pteF0GIDwnrvzW4BVXesRTdQyH0cBJKCUrFljBK5R4
         FAtgyNdUVQYFZFNZqmcIEKZiXgWcAAJW+SXMUvUt1yLKEKKSoQ/tfdBcKHmMuV78OKZy
         NSKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9XMkM1DABJcfB2sF55dW3udzh+YyOX3wYbWOhrXt+ta6Nkx5YLhx6ZZ4sjgPFGjTSg3VcQGniG5RsbfVwziTXZbcjDORg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxniVUrLPzySeToP1UO2KoJgwBqPktvajSf2HVtCHJxtzOLmjzX
	FPC9RyvhlIzc3QGqzGCp973FlfTgYP7aboNXwc+qKUtZ/6iQEVgmcieLhhSyMhB88/ps8Kms1N6
	DzTUwjxmA+JIn9/ZF1D9fkf8cadFoglw=
X-Gm-Gg: Acq92OHbQrj7OBH+OVtuSsA81FgxExEMHpoCJo0/Px5SMwbs8bB4PH+7mkJ1VNNzYys
	CRJ4e9c5/It7UvpSOcid3fNEuHQM28VnSo8uT9cH0hTNYrk+Rsvy6ck4Q+fk66Fn/yWmQB80yBs
	GVIMg2Hvr9YNHUeq9Qzk6ZGw/KzJBnTlVxzEWyU83V4MLKIkcF2mAeA66CvTryq8eghkvc8rhHN
	qEd2CGKEzAJsM1V0Jd4uM4GF/hyU1s9wfXy+8FQwijrHDS8210JdLEG64esXilaUonaqYKewg1f
	YckiDHuPwNeaGE+Wk5AMeBdTc+gYlHkUK4xL69PzZ/jNuKGN/lodTOzeXgwVtu5cFLRIWA==
X-Received: by 2002:a05:6000:480f:b0:43f:e43a:f4a6 with SMTP id
 ffacd0b85a97d-45eb3691f71mr10856462f8f.6.1779525645710; Sat, 23 May 2026
 01:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522023234.3778588-1-kpsingh@kernel.org> <CAHC9VhTk3qovnQQjK0C_FWU605j6Yi+-poMVVMS8WycRFg9xhQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTk3qovnQQjK0C_FWU605j6Yi+-poMVVMS8WycRFg9xhQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 May 2026 10:40:34 +0200
X-Gm-Features: AVHnY4LlOQmp4YX4PYqO36uOP6iPXDHyE9oy_nP2q8n3NepeatlO_xQBklFCrKI
Message-ID: <CAADnVQLbCz8nCLS2W=Hpk3hVSBqHGuGyVjeKYPnNDhhu_1UiPQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] Signed BPF + IPE Policies
To: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 8:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> Blaise has recorded Alexei's NACK on the Hornet patchset and addressed
> the TOCTOU that Alexei identified.

It wasn't addressed. You simply ignored my feedback.
sashiko spotted it too.
All other sashiko bugs were ignored as well.
You merged buggy insecure code.
