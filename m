Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1A32D620
	for <linux-security-module@vger.kernel.org>; Fri,  5 Jan 2024 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGmAB5a1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704461118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X+N2QN09tRy41VD5NIYroenQi57udRymfLPwCbxVPuM=;
	b=GGmAB5a17meogvAcRiiMEnTipLtzD51957YlTocFfDEal3vmf/Rs/Hda6p/u3oGMD8oToC
	chfhZwSb3VLN2z3KypR/ehua4y+HgoPo/5XdeBcgnVBksr+p2CtoJezvvLa3VUTjxJjs6q
	4kvAkDqkGU1VIQZmQVs9VqUvZpNlrkY=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-EG-_HI8MOUSJmu5fcxGnfQ-1; Fri, 05 Jan 2024 08:25:17 -0500
X-MC-Unique: EG-_HI8MOUSJmu5fcxGnfQ-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fd46fe86aso15446845ab.1
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jan 2024 05:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704461116; x=1705065916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+N2QN09tRy41VD5NIYroenQi57udRymfLPwCbxVPuM=;
        b=PUi4o/7ykl4/U385pqSXP1p0s194siHeaSL/TusWlRsqtEdUelFohLHCHtJ1i5ZWEs
         +AC63kLdZmBU4aYDO+q/fO50RDVPZ9gJyZPwK+UpWUVys2fIMMGNpE26HgHy61eQhMa4
         i66R+UA8e9hVHsY71Iy5TWXEl499nH73tNX25vFszk58AqgYxTE3X2b0JpRE/dLWh3j4
         fGukaKqwJheiI7cmSwO983fjJimoRiebRCx/HnAaHVu+IbuhDzbvc3HrehDmjMi9gucL
         I5KF1h1jOciz+w8blYavL41ob//RlZolkeyv+vdIgd17jegII3YhHoAHg2IM8CkaDTPt
         Kg1w==
X-Gm-Message-State: AOJu0YzaQFizTygRbUkuKIU5FV2g7usvHOxtJUtyt7pX2lQ612FXr/Tl
	065bPK4eJPqR9PYSwir+T+YTmTeWHq9nTxmh5sg6D1/P8+CRztf4MNMENa0Lxq8/185o7g1erg5
	7XQbgoBk7GiC1nnW5sFRZrmppMM1j/UEGInGPUAyZym+16A2q0PqkRWqrKw==
X-Received: by 2002:a05:6e02:1788:b0:35f:feb7:35e5 with SMTP id y8-20020a056e02178800b0035ffeb735e5mr2486080ilu.69.1704461116338;
        Fri, 05 Jan 2024 05:25:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUPQheyiFfY5luVUQI5Mu+aTbDrNLu5ERwC9srQCSZz+wyviXhwj8/teWqfyQ53IB+42HnPQ==
X-Received: by 2002:a05:6e02:1788:b0:35f:feb7:35e5 with SMTP id y8-20020a056e02178800b0035ffeb735e5mr2486069ilu.69.1704461116035;
        Fri, 05 Jan 2024 05:25:16 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q68-20020a634347000000b005cd821a01d4sm1383371pga.28.2024.01.05.05.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 05:25:15 -0800 (PST)
Date: Fri, 5 Jan 2024 21:20:45 +0800
From: Coiby Xu <coxu@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, itrymybest80@protonmail.com, 
	Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] integrity: don't throw an error immediately when
 failed to add a cert to the .machine keyring
Message-ID: <43dozoqfip7m6nglbwzwyzykx23fpzbp7d42pcqzudnzlfvfkb@yjvuo5a6suvv>
References: <20231227044156.166009-1-coxu@redhat.com>
 <CY54Q6U6UMKM.2H5N3BACDBGU0@suppilovahvero>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CY54Q6U6UMKM.2H5N3BACDBGU0@suppilovahvero>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jan 03, 2024 at 04:09:29PM +0200, Jarkko Sakkinen wrote:
>On Wed Dec 27, 2023 at 6:41 AM EET, Coiby Xu wrote:
>> Currently when the kernel fails to add a cert to the .machine keyring,
>> it will throw an error immediately in the function integrity_add_key.
>>
>> Since the kernel will try adding to the .platform keyring next or throw
>> an error (in the caller of integrity_add_key i.e. add_to_machine_keyring),
>> so there is no need to throw an error immediately in integrity_add_key.
>>
>> Reported-by: itrymybest80@protonmail.com
>
>Missing "Firstname Lastname".

Thanks for raising this concern! I've asked the reporter if he/she can
share his/her name.

-- 
Best regards,
Coiby

