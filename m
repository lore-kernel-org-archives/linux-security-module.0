Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84E41DE8B3
	for <linux-security-module@vger.kernel.org>; Mon, 28 Oct 2024 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133423; cv=none; b=DIt5Sv5cT85j9izoTndecqxorIpMnmpMIBuuPuqo83lAmrmbhkA4WEqtDBKwx9657QuXY3b0rF24LtQJ2EMS35VG7/NouNGRuH7ZeYmKpVrBECn4bmnaZ2MyF9ugcSRaeFQCNBvoDotSfQ7RcYnP4bKpdFXZJDb7Kufg0BZdUnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133423; c=relaxed/simple;
	bh=A1cFervhOMCuUn1qMqZ24mOHhDxMc2MaSueVuQ58tpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWvNB7d5QWZ8UcTpprcSnkPfY6MnzXAWOOMHwel++VTARQja4KyTJnYRXhRqCZA1h1/+mlWzht5/9nhFapbxYwa/FzVTkvBrezgIi4L01Q0YhLN+EEhd/eYOoYuO6hObZMTOmz++WihmaAJxqKYxeTJ/quiliH6Cg+ObLqx6IgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QL4KLo94; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QL4KLo94"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e2e32bc454fso4373757276.2
        for <linux-security-module@vger.kernel.org>; Mon, 28 Oct 2024 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730133421; x=1730738221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JC3jVJVkR0vXjc9v4X5cqN3AeydRxh4u+9f7UYh0hzo=;
        b=QL4KLo94HsXvdRICxiDuQJ3PVBugrW0AUDDLQaUqDewXpA/OdPnUfAoiGRbvoseDpX
         Ohjrfv4wYFXICHSvhpf6RP2hPaocKZeWIyu+NRQ+Ng8SYaetmCBT8xqFqgaJxK4ypo0W
         ympdDK/qdEuv4Fcz3GEL+NermkJosAO1OG7M2+ymGR0t29b4wkmKyorR3Vsa/M0WQHqv
         90VUAC4reIdNd9PcXSUbckPctQJbUGP2voPshCZoBuWpgmYG5mi9zCRV9oUB8By8a9MX
         3Pmq5N+dQhxFeNb9uLmEoi6acyFp3q3T5XeiHr/rPodbB+52REp8o4Hcxa+OfVYq7RhQ
         LQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133421; x=1730738221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JC3jVJVkR0vXjc9v4X5cqN3AeydRxh4u+9f7UYh0hzo=;
        b=gPiSFoo+t5cqq1o5+mX3jSvTdus4ezhMkMGd71cjtMIidcNiCAnLTizB6rvGoWX/LV
         EpRqL5Ld4VRKrIf6v7v80Ds/WQ/okP5iHP4Ezhtpfwovfi7LVJe9Xywz1aX5b9ssMGzV
         npTnkOPl1+8V4D68NnpROdky5+J1QkGlmx5RFFv6pujVFHl720BlGeBZRE/DS40m27QW
         wcULkpkEk9oDXOu4FSaBdOvuZ0Xqcf160s6X4IEgBDcr7FPhavSTXTzilDx4zzs88XHT
         YOAUuNIv6ngKZDvsbKKmLZnSL3E67b5MLhrpkyQhLxpX/2LTJrjPfiWGxDcdss8Ojody
         ZWvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXd5Mb3OiEbY8n9WV+5qW/0vyZ5vNXpjNMu9FgiJFX25fK6skddnuqaRadTUgNe6rJja4S/3vvwIKsgXTsCcNt4jDQ/y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk24Mj3OurOkXMxxJL707Eqv3+PjYeatqb41q5vlujUJHrRWXn
	XdqwufEwf5GgM6W24JYq09Ybomg+RKKwaOG+hXuDd0Nopn4Ev90AcF+LZ4sprPBBhHviRq8XHvb
	JbspsaUlWESGcsK85uJ+J1Yat10tBsO/dZj/3
X-Google-Smtp-Source: AGHT+IHkyOUSrZWPFA3y75jsiO35BBFsma2xgU/eoM7XLdj4xLkzEHV54DlON8lAoxScSinKd0bNayTWXt4280H+XTs=
X-Received: by 2002:a25:d645:0:b0:e2e:2b20:492a with SMTP id
 3f1490d57ef6-e3087c21336mr7425173276.46.1730133420732; Mon, 28 Oct 2024
 09:37:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028123435.3495916-1-dongtai.guo@linux.dev>
In-Reply-To: <20241028123435.3495916-1-dongtai.guo@linux.dev>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 28 Oct 2024 12:36:50 -0400
Message-ID: <CAHC9VhTC3OgGy7FrmPTOG_qLoPFbUFqYa+bJvfB2q+uMkQWPWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] netlabel: document doi_remove field of struct netlbl_calipso_ops
To: George Guo <dongtai.guo@linux.dev>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	George Guo <guodongtai@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 8:34=E2=80=AFAM George Guo <dongtai.guo@linux.dev> =
wrote:
>
> From: George Guo <guodongtai@kylinos.cn>
>
> Add documentation of doi_remove field to Kernel doc for struct netlbl_cal=
ipso_ops.
>
> Flagged by ./scripts/kernel-doc -none.
>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  include/net/netlabel.h | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
