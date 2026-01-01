Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D203A1E9C
	for <linux-security-module@vger.kernel.org>; Thu,  1 Jan 2026 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767310854; cv=none; b=Jhzr0tpuLT1G5mpnGAevQah4p2TuUab1sIM8FZ2GZjCtaaTTUDBajUZHg7t4d4kYbCgO+/xvQMlPVYVSzL50qbzsWurDRurChblWiv1xtp8nzpAoW7dD4Y3/tIZ92ReO2RV94emLl7ySIgEUFAMYWfON+z0ahYD83ETRNsF8qJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767310854; c=relaxed/simple;
	bh=cHaOplRIv2s5yEHDc1ml8DnxLbzB5UiibX4F6W3wE34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3WNzXwVC0hd1RInSI41e7qC4J9qR3S3rBWXOjA9eyGqH6J/vauHZYvPCcnJ9mlyHAVwoGzo0N6/qUuNokbOZUfmLldDZj4OaowdnK1a4o/0bXFl4nWleZetoqT2F9oGUpT3i/u2/SgKxvy7a5NkUzR96KXJd+CloaNhoLe4Ay4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0/iEmZZ; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0/iEmZZ"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6442e2dd8bbso7953575d50.0
        for <linux-security-module@vger.kernel.org>; Thu, 01 Jan 2026 15:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767310852; x=1767915652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BaZgB/0vC9aWPnmDin2g8hReSOJZPuV1mCiVW+Kasj4=;
        b=O0/iEmZZqSD9Rc8fkyV8S2qn6GX8EyJj7/+lo3yO/e5ySoJNGm2HmM2iQDCBPyiffG
         ecHGK/XR3PLenx44KuDjMoQOrsSOI/6xawQg1C5aMaxpoqb8fckDFkW9dkfZ5dISdXvD
         51i7d3sk70ZclP4ez+SbzIyYerftuq1ufPujG2RZ2LbLcArmLRXHnN11ckhfCOFqIXO4
         6QlbLAwzwSNLrnO4cEJt80we8L5LBfalVPi/GxCi+zpYml3NsHEeBwuV7DkVIlQFIZdd
         eVClHn9MuL05h9RVNWfQMJ5a/LEE5dGfJYQY6pz6yfba7qQne1FF81EbPBRM4XdD7M1u
         6LsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767310852; x=1767915652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BaZgB/0vC9aWPnmDin2g8hReSOJZPuV1mCiVW+Kasj4=;
        b=SaerTDfoI2vb5PK6QgGfe97xkwJ19HHGHqo5FHNTAJti0LoO81uYlRw2dlGDrTV2iJ
         n9FTfxDO90caDP6W2La4CMwDLT4piwo5baGUc0XyLNTkflQAhV2NgauvqiTN7YAnDmjw
         99mA6T3tFu0xXum1+soVhLAJszshR06WBK7gXMwHD66GkupadMkiabGux1a8q0lHbxJs
         bvphnig4n4tcPMTEI4rCTkwfPmm+alqaOtJtda+Ei2VmuZk4wADK3JO2PiI13QtvJJnS
         eJDnDIKwtB9DPDuOUZTzsvpAJyCXOASjbEFVlmwTej2tMbVLoUqbJjCYA/0lhNn4cbOO
         x8ww==
X-Forwarded-Encrypted: i=1; AJvYcCUdcelQbu9Lwu2nPMD3o9qsyB2iHA9sME3IaFRdJDRndn8WM38ZiMZAfasDF+f9Tg1LH0WHxDLI70va7RzA6pWCh1wEG2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqhHP5uOUlFNA6IEP4GKpecSAeM0/n5OsPUjCKsE6+V5x4A/IL
	htOQTeJyzM1zR16YHP3h/9Q5blVvZ8D/nR9bKuEBQ2HCYi5D5BLY5wh8
X-Gm-Gg: AY/fxX4UpGJr930xQ0dTlwhDMctMAujdQmijeaDeE2I2qdp8bh5WQye/D7fCF43L8ti
	s3vXz9LlBMgk2p73rfipcomqPZsap9ifVdd8nh3fNW+iGVgVaJX6hfZlej2CPYX8uyMNChCHvyF
	K5ldzfUYG2qtM5jaczrWJITiluyxbSFakL/mdm2fmkbYRUMG3tAg381vHhLcCkIlJxkRcKtnUVA
	xPXGoDXMubD+aQkpV+YagAX5wAPKW0V/M4ENMJji2Gjyo2uCTFW1k0pB/Z8h3UIn1g0u9UJJ30+
	RU/PhSlS3n7cTTt7c9aI8uo0RWEFaAUwU4UjdMiij2XGnClf17aljdj08uZAVpUGIa+SVe6Atja
	ldz6DXubx49LdVdj/vCVZWeWG+kAA68h/xmeoVTTN8GfnlRBw2KC/1YC8/ZkjPf4F/pt3W50+3K
	cGRkD+SEwWJ/DCVeo8139zKepQXMV873DnCGkL1ntYUoKzVyf2y8Gywkh3tcl1jjOZ04pIjg==
X-Google-Smtp-Source: AGHT+IHO4l5iOHN18kmUpzMMZ1XijQJRBwTQEPahlD7N2hLnBbuPsKliSlV73wybrZLK6ihf+dc6og==
X-Received: by 2002:a53:d846:0:b0:63c:f5a6:f2ef with SMTP id 956f58d0204a3-6466a901165mr25743473d50.65.1767310851998;
        Thu, 01 Jan 2026 15:40:51 -0800 (PST)
Received: from [10.10.10.50] (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a94072bsm19229805d50.23.2026.01.01.15.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jan 2026 15:40:51 -0800 (PST)
Message-ID: <714c39e3-61fa-449c-b4ab-bdb41a35fc40@gmail.com>
Date: Thu, 1 Jan 2026 18:40:49 -0500
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
To: Tingmao Wang <m@maowtm.org>
Cc: gnoack3000@gmail.com, gnoack@google.com, horms@kernel.org,
 jmorris@namei.org, kuniyu@google.com, linux-security-module@vger.kernel.org,
 mic@digikod.net, netdev@vger.kernel.org, paul@paul-moore.com,
 serge@hallyn.com
References: <20260101.f6d0f71ca9bb@gnoack.org>
 <20260101194551.4017198-1-utilityemal77@gmail.com>
 <b992df90-92da-48bd-91d1-051af9670d07@maowtm.org>
Content-Language: en-US
From: Justin Suess <utilityemal77@gmail.com>
In-Reply-To: <b992df90-92da-48bd-91d1-051af9670d07@maowtm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/1/26 18:11, Tingmao Wang wrote:
> On 1/1/26 19:45, Justin Suess wrote:
>> [...]
>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>> index 55cdebfa0da0..397687e2d87f 100644
>> --- a/net/unix/af_unix.c
>> +++ b/net/unix/af_unix.c
>> @@ -1226,6 +1226,18 @@ static struct sock *unix_find_bsd(struct
>> sockaddr_un *sunaddr, int addr_len,
>>         if (!S_ISSOCK(inode->i_mode))
>>                 goto path_put;
>>  
>> +       /*
>> +        * We call the hook because we know that the inode is a socket
>> +        * and we hold a valid reference to it via the path.
>> +        * We intentionally forgo the ability to restrict SOCK_COREDUMP.
>> +        */
>> +       if (!(flags & SOCK_COREDUMP)) {
>> +               err = security_unix_path_connect(&path);
>> +               if (err)
>> +                       goto path_put;
>> +               err = -ECONNREFUSED;
> I'm not sure if this is a good suggestion, but I think it might be cleaner
> to move this `err = -ECONNREFUSED;` out of the if, and do it
> unconditionally above the `sk = unix_find_socket_byinode(inode);` below?
> To me that makes the intention for resetting err clear (it is to ensure
> that a NULL return from unix_find_socket_byinode causes us to return
> -ECONNREFUSED).
>
I'll do that. That does make it more clear.

I suspect resetting the error accidentally was what caused the syzbot to rightfully complain.

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 55cdebfa0da0..2e0300121ab5 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1226,6 +1226,18 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
     if (!S_ISSOCK(inode->i_mode))
         goto path_put;
 
+    /*
+     * We call the hook because we know that the inode is a socket
+     * and we hold a valid reference to it via the path.
+     * We intentionally forgo the ability to restrict SOCK_COREDUMP.
+     */
+    if (!(flags & SOCK_COREDUMP)) {
+        err = security_unix_path_connect(&path);
+        if (err)
+            goto path_put;
+    }
+    err = -ECONNREFUSED;
+
     sk = unix_find_socket_byinode(inode);
     if (!sk)
         goto path_put;


