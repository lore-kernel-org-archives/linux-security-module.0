Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582951;
	b=IRTvpfdLoLylUtzudKW/qYMWrZYsxQ6gXWCHXIkpzpiXQUxYGoKG5dldigEjkqgOboLQ
	 X1JyZzqXZv/NvypWoQK8S++0+dzRs0ebwlogamrc2qwlILczMP5PX0Bqf+oFqd3dlIaz/
	 JENkHBgOZqigtgVvsQJMry3ancJXdfPDsKkyFnjgqaYSnd3NRdjlyKVlccw5UJpel4/eZ
	 NeodSQ01Y51ErAQlDDH5m3vmKXn5nszsHklvMQ8eSGsSrIul2YCXUALHXK3SAX26aRzP4
	 Od+jNmgCKfyiBGgx0nnn+XsK385c1OqAvc81vIGGs5gYoMHgVoLH7Ju0PXVk+pvm8+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=G4x9g3bqlTZt05G4xvm5t1Rd2JsR04WKB6UrLcml+cw=;
	b=A1P3iqI1LrNLifZeu9ySCHZwL+H/mgCBldz3RzRFt1Awj2u7PNij46Tu/kjzt7IIvPnw
	 +TMCdUSTIjm3fDPiCuXmQdIdwowuN+xsCt0cWZj61aBSR/QHksLWJslcNVE6P+gklLPvW
	 qJBgIGBQpFZdjvHv/P5TOB8wOU//id6rV/vCDforMF7KDbff0szld6tjuwKfoZmBHwJtl
	 p1BI3WAD79AW+4JQ2DOQmZVnEFWR5+GIBqgh92SiR+MmRBoYV6GMDT5j05fEydMseDCaW
	 z/q+zmk0xzkLgcOhga/I5c9hsX8QC1Cyz+T53FGqz07vubohrdI2nir1VhtFgTYefIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YK37+uqO;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3FE606A327
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 15:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F3FE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YK37+uqO
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so16425615e9.2
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 07:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794582950; x=1795187750; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G4x9g3bqlTZt05G4xvm5t1Rd2JsR04WKB6UrLcml+cw=;
        b=YK37+uqOIExWt6SEWEpNPNJi1YLCKu29di/qyfZKUEYBz3CWhdwJlkttYPW+Mq6DKn
         7UBFA3Oyo4yaCQ3V2ccqGJ9Iq7IvQk47WL45MAkOheXuvPrjmSVrupIiHS+Wufls7MpV
         ZbowRGChbGgbZxy2IHzig8u8hk30TVJldWTpCXOQQSMQghSUqwYWTmd0UIzDFfw+GgnC
         khg1U3qiQ728D03f7VfQRizVVarpVgeGXA1prFs1v3KmHF7qs4R5tieQS03B5zmh3Zkt
         no2wx1T4hf8I2NTZ9UuB5DOpqMGUSd1MI3al6D8P5o3wAdiz4MtziK64BFV76M0+HfJX
         Jbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582950; x=1795187750;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G4x9g3bqlTZt05G4xvm5t1Rd2JsR04WKB6UrLcml+cw=;
        b=RMWLDcdtCqp5X76wQ5Eww/JGgd1iV1OmEWfbWp2KdKoY6qS/njgaSzY2SjZ5e+8Av/
         sdAvO4QnQhw/DARi+sZGY32/HJlNhvC0igzuQmSPgnCNO8S81Zb0RjDfL/Btf5pwFXeB
         ob2GWeC2BP/6l5klB4wXVEwCkSqAYCyKTbLUdFKmgLwuBqQCFRykY2Yowu8Ky9E+lfk/
         uXR7JZ5Pt442p36OmzsXNqq5UI0UGIEThD90swgaocB0C7Qza+/o2OJdIwbaZKSKI1nQ
         1bKIf4M/ORMDBxCpsFSfxUeEOt1RdHt3vTKIO7bQp5lfEg0r0rjz+6N1z7LtO6Md2B/P
         Efog==
X-Forwarded-Encrypted: i=1; AL+hErFvwCq/CfQE1r20Krdk0yX9OLU7acBDcXL1niYqY8rIxhv5yc/XW7fRvBM0R01IzDQ8dzXBkXKXMhmOxXRMiyCV62OUKiI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0GdXDQiGAvJLSTBoIgzbda+zlT9pLOdSdlqcJZvSkOr1G1r7t
	wMU/udmvNlrMuwNr3MEeYXUi7H3h5N81AQLQAmQ7G90bFF3Mw2JiYtvkjR/5ozct
X-Gm-Gg: AYBFou0h7RgdpGnSWMxcmWFvi4mQnvUqbYFy1gVVCpcvp0aZHB3OEfoDziPP0SLqX0F
	Zi/6yHBK32hoXHtSfa8uI5deL6ZXgl6ktwSI2mOX689WcHsy8eYrzkeI2r62kzD/lJ/jCDEnQb6
	/ojg0f+qRcug1DK7lJEQ2hpE1++XVw0AYDXlbcb3aG3D597xOVvE2Jyzxjt79QLOp2/itiWapIn
	ZyxqkZYPYTH1B64vg6d7/RxODblPb+QXjpn6Kge3TJyCaHhNgZ6SBCe8fQ1wLgk6+KRXNjGsi+g
	hIzE67K5eztkxkAIJ9hpce17BzMEXBpqXZsEAekh9SWenVBSRtv9iHmpBfhF9abNDXIzTbpqZ/j
	zlQH0YMLpd7sUul3FOc91UlzjKNS33jcbXF3fVXdC0+VUNGaEPTTW22p5ffBVCQIFr7NlcaA6vX
	E9PtP4XC17gB+4cLm/pNHXkwwUnkHrfbE1kVHL41gbus2Td4y254NQaO6hn+ksYS7NYdVL9kn9a
	Y42y79XzN0CLLUV2ni5eIui9C7/36+L/lUr/pZOYGuyiOCqdoDTOV6ArFMmHL1iD6JZw+pF2T9V
	xZwRk2NhoprDgcaSxaVePgkX7MiSSCXz1IyTLX8dRR1I46hGPOTWRw==
X-Received: by 2002:a05:6000:2084:b0:492:46e:d4ce with SMTP id ffacd0b85a97d-49c6fd932c8mr5563052f8f.13.1794582949657;
        Fri, 13 Nov 2026 07:15:49 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm5971522f8f.28.2026.11.13.07.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:15:49 -0800 (PST)
Date: Fri, 13 Nov 2026 16:15:44 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] landlock: Fix layer composition of
 LANDLOCK_ACCESS_FS_REFER
Message-ID: <20261113.a61c6a4b7c9f@gnoack.org>
References: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
 <20261108-b4-landlock-refer-nonfs-layer-v2-1-2b405fc1b3aa@gmail.com>
 <20261113.hij1gi7Ees1A@digikod.net>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261113.hij1gi7Ees1A@digikod.net>

On Fri, Nov 13, 2026 at 12:25:07AM +0100, Mickaël Salaün wrote:
> Good. Please add erratum 5 in this patch with abi-4.h .

Done, will send that with V3.

–Günther
