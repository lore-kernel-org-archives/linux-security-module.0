Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A21DAC97
	for <linux-security-module@vger.kernel.org>; Tue,  5 Nov 2024 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827768; cv=none; b=hugAI6ICIORa+trCSPACBBy7Shy7LKmsSeFc2SKUCip0MUcMXRkhOSqTPESsiQ/sdsyUEFXSU/07Yrcsai0qktZNo7TjL8NmISeEsByCXbQeyC+d4gHSwRKSNwKUP8Hj7Ed0KD4cS0dGvi1FCjvZLSICa14MKeeKpqLcIloVDpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827768; c=relaxed/simple;
	bh=2QPF/Ug8UJPBY50upp7P8DUv5/Sc8d7YuMooAZdQhyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2TIAPkkyxwjlHssu8HcW/wbgRMnYZQEaQMvqwcFm7XANobhVkHcpc9pjghy7G2jQy3vLhQ6azEkZV6GN4TUv9Z60tqgoxXj89PjkajalObqsvs1VZB7CWrU21LzhYYuCaNGj2EwFX6qnW9ru9uFMeM+otuE76a51GbHOKsOAK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VMt9XOOx; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VMt9XOOx"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e377e4aea3so47474507b3.3
        for <linux-security-module@vger.kernel.org>; Tue, 05 Nov 2024 09:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730827766; x=1731432566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QPF/Ug8UJPBY50upp7P8DUv5/Sc8d7YuMooAZdQhyA=;
        b=VMt9XOOxUljvPEn+YrTy7uje8xYkl4Diblc/eRGVHUUPANWCiYbx8FJFDk2v5fB+Ij
         9ma6bOMUbuXoY3VNrHkO/8zfTK9njeN1c6oaCDhku0BwV9gWt/3G4nQlV7IYUQljNW20
         vTES9ocuRSmq5GvYDFnCNtna8F24FQK3R/ba4SLYxXDlOqC5+J8+l+MFlCT8wYFBFLLl
         62vubymJ4Mdms0Dz2XyN4UmQRdsdvFIWcXRN2vWYFokH6gTmyoAgJKJffjpdV7cj1ihO
         Poqa2P3id94ufFaNMfSzw0yihW+plA0Wf+NfbiloifpoPA1X/QoD8k6lpWbUPDTuQa+r
         0YWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730827766; x=1731432566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QPF/Ug8UJPBY50upp7P8DUv5/Sc8d7YuMooAZdQhyA=;
        b=FDLn0bah//1H3UNrjiosqpe4g1bQKeyt9sHtFE1Ud3qg+hRHAYx126zOUzrgRNz95u
         Js4rt6Ie4Np/4jTJ/ZQZaK7EwqKU7MLqzdnkS7NpifhDYtmnYfbQcUFXhij+/7OnF/lS
         cwmss+z2mPR6sDEQUWoPHJkNLiOu5cWumqs7CJew4Se9IXpp6FLZxv3ttQlu2qzVy2b0
         mIiir0+Tn2mj5oeFGqv8w2B56lvNLQcj7AqytpTogLQEN8CH8wbXLJk4EJpODWShKd0N
         RRA2MIhLL/jhb6Kq6cLo5M6Pvw+gK9adhvx777guT3kT8uyOnEq4eCHP+v4QN2+ssz46
         SwXw==
X-Forwarded-Encrypted: i=1; AJvYcCWcp2QRh/zb7FiCyA45z2gfa+Go3LPU3Kks0iVIXtpizLkum7l0RPfaJ5oAvJhJnxF/JIoQzz2qeiFBICkR80WLYoQhC08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhWzCP/H4ecC6tkGgku4svQOqKB6shcc7AJFCypvrOhKX4Y8Hu
	Ck61uELt9IWgbveS/yrQieYm6HjVthUgG5KhECytNGY91pW8TpQP94ITYac4WNykvu5jwYset5F
	2/J1Enmw/FYZdRp4t5Aq+/G2sxLI7MG4Zsg/I
X-Google-Smtp-Source: AGHT+IFOtdS0rX3FHLkNcUtzfAk26Yond8xCj8zU0zoLRnwQv6qRHEuvJmQX5wXTy8+vzA4PqpNS1GJcb9sSajMI+aQ=
X-Received: by 2002:a0d:fc04:0:b0:6ea:7c46:8c23 with SMTP id
 00721157ae682-6ea7c4693e3mr84772327b3.35.1730827766330; Tue, 05 Nov 2024
 09:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011150522.2697216-1-stefanb@linux.ibm.com> <50e5cfff-94f8-4a45-a32d-9cce4f48d5b4@linux.ibm.com>
In-Reply-To: <50e5cfff-94f8-4a45-a32d-9cce4f48d5b4@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 Nov 2024 12:29:15 -0500
Message-ID: <CAHC9VhRqqxty8_ht+S0Wp-7hgRT7tzP+FR7-P-kui_OkfnPFMA@mail.gmail.com>
Subject: Re: [PATCH] ima: Suspend PCR extends and log appends when rebooting
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com, roberto.sassu@huawei.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 11:40=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.c=
om> wrote:
>
> Tushar's series is still needed ...

A quick note that Tushar decided to leave Microsoft, but there is a
new developer coming up to speed that will be picking up that work as
a priority item.

--=20
paul-moore.com
