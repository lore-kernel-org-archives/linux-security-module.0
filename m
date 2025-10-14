Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3D30E0D2
	for <linux-security-module@vger.kernel.org>; Tue, 14 Oct 2025 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483582; cv=none; b=pCdxYLt6h9sj24hF9mwd/vyP6WPhlkjJnIpUj9wsFtIuwDvuuHkjsjT4n5eusV9kYNMrANrT1N7RtTXgYYTe+XSVrGpm5NOjPPy9qrxrVxv3303LoNNOuDDH9Yml9NI2nPgsHReGr865PCcT/HsL8CfGisVKc6TRwTg/zRahUCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483582; c=relaxed/simple;
	bh=2OjZR0xIzGES+vVHimuhr1zX3QGgjQKBqN8vzmD73Qs=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=nwkjWAoBHG/bZYdeNYAzn/vIwoYt0O4XZzERMhT5A/hLgS8lQqxCRRQXjOKp4qMO7tjCW/6W0coqh3M2sBOdPWB9fu3d8km9XOl9qlyDhQFxRrJ5cEn/6uJGLKAA8YiSaQTT/SgmT1t3jrubGB8xfAAZkvHRe6tlLrvLhmMNnWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WMyFQcnO; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WMyFQcnO"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-87499a3cd37so54039856d6.3
        for <linux-security-module@vger.kernel.org>; Tue, 14 Oct 2025 16:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483579; x=1761088379; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtW7xGM0A0i7bPQL5H3HW6xoKoQmcrde+jRMi+evfuc=;
        b=WMyFQcnOAdB/+dSch4ZN4hT3y02F1Jxkg6407M2HSVC6sCpMjABchEszuEZXFkOjZv
         AcZMRdb3M0pJPorj69ymuxVr+f9TiowBWhxn428bmBRA8pxgRP5uCBWj2tHRmvgt0Yc5
         cls1grSuL3az3zgt/ouDRbQ088bZabq+Nn8wyJliCUpl4KpTpMG/8UnBDYE55dmOUac8
         GulLGa6WPgFfbLG3S66PPcuUwyu5RnSP5pHlg0W5nmQBrABhvVUGqJNYctvzFJTDS0Am
         QIOXzeeZdqujE6G/ixfdRe0VHk/aVeh6YtXTsvHix9+m7LLnBKyHjuY5Amr1KOfgQd5T
         zqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483579; x=1761088379;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mtW7xGM0A0i7bPQL5H3HW6xoKoQmcrde+jRMi+evfuc=;
        b=t9fI2Uonnwn+molSyFRRTikdapVjx6zvWsqsHTKa2DrqfVwuEsjjVO06Gd2SbX8NMQ
         5Scjxs4avihN/ykxdGIAlUyXSawun8zJ4E8zY6VTI5bq885X5xJMK1o1mm3pwVt2nLyB
         IBcGBNJvryv17nxAbtYfhAP1trcaI1ewLYp53qKI5/qrcg85qhKwKAGBKUxfi44pTrvK
         swcYYYM4WFZ9BM3TkkHmUwgyJOi6rcYpK8HZX+PbQawaVHtotXaq4yfCV+fG2hF1+mMA
         Hx/p0WtYnJSsHhsFYTPk7ofPd4MRK5RLLqlqtrhfioPC3O5mE41I90RM1qiHux2XoaeJ
         cv1g==
X-Forwarded-Encrypted: i=1; AJvYcCUfU/wED+Un9MBnwH1HTef/1o+I5+b1Tqv6oqRoAPqMqQkKd2XqBxcsKKxpaM4msUbRSGldSgHGXlyTY51eIfHozINPWKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN28LIBF/m6mU6wgh19PCs/8XFxCUSkHw+kCA3BRQ5+V6joPkm
	wxuJOTknqz9c08XSfWS0b0B5trQapE9eOrkcSJC6Fh83yNkif9XpDKvHhMzcnyRK6A==
X-Gm-Gg: ASbGncuHwWUstpOnc35bzDkySJ2sHdHxdw7Pt/j1p/v3FhQ2CDABX6Kdfj5yxIkaFwb
	108yJvY6+u24o1KqnicSBx55GcF8JTmnqOOvei9xA0iky8Cl4O760Rgl2PPd/INgJ46e9WwhPx5
	54S5rB+Ha3gDJDEqqwFTHEvq55UdVYLhhx9RKwvDBZbELibYsXSpstJAs5zWaYhHS8SVhCm4FxH
	/fhqgLvHHL8bErJyEMpVx0KcJ3KNbOAhLRyq4qlwTXIg9QxDblqbVzS1DboZKSUX9S5UfUyXjMc
	Y/A2m0Zu08/bgs2f/fKC01ViV260cdcltY1pKBeQZFZ+mUTUdxoz/hogzeI7WlFaWV7YLy0dr9T
	6zr/zioDU6omKdiE2eq1z6KRY4oI+LbaLtP4811TeniZG1gguGJ5YJ/FEsHMOPl2bCoDRhCQ3QL
	O5pdlLUuhtUCORQ1JpktOtuw==
X-Google-Smtp-Source: AGHT+IEptTo2pxg8BQyRH/EAXGF7Ajlrs/OC3K7xB2VEK00ORspclexLASyXzj0clJy3+lke8DpgeA==
X-Received: by 2002:a05:622a:4814:b0:4b5:dc7c:a6ef with SMTP id d75a77b69052e-4e6ead57ffcmr362320031cf.50.1760483578960;
        Tue, 14 Oct 2025 16:12:58 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4e885f1bf3dsm517031cf.24.2025.10.14.16.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:12:57 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:57 -0400
Message-ID: <3559abfc0d5ceb11f03451aab517c8d2@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 11/15] LSM: Infrastructure management of the mnt_opts  security blob
References: <20250621171851.5869-12-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-12-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Move management of the mnt_opts->security blob out of the
> individual security modules and into the security
> infrastructure. Blobs are still allocated within the modules
> as they are only required when mount options are present.
> The modules tell the infrastructure how much space is required,
> and the space is allocated if needed. Modules can no longer
> count on the presence of a blob implying that mount options
> specific to that module are present, so flags are added
> to the module specific blobs to indicate that this module
> has options.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/security.c        | 14 ++++-----
>  security/selinux/hooks.c   | 58 +++++++++++++++++++++++-------------
>  security/smack/smack_lsm.c | 61 ++++++++++++++++++++++++++------------
>  3 files changed, 85 insertions(+), 48 deletions(-)

We discussed this patch in a separate patchset, lore link below.

https://lore.kernel.org/linux-security-module/20250925171208.5997-1-casey@schaufler-ca.com/

--
paul-moore.com
