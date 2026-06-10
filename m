Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D2E15746F
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 23:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781133177; cv=none; b=NOLhvRZSNYF/bDMlkBIeXT6tky6H7ThQ8uS7RNDp13qnZ4ls1gMlww/9X+PUNK5nfV8DTYsSXg5IDgSbmATNvTGc3kGXUuL8Z3RmZF9zI7eSYQYEx6oaPKYJ2SICsjUZaVjQ67Iu/7QiplmKRRASfjYoxZyEvNnIIA8cFRb0DgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781133177; c=relaxed/simple;
	bh=pj07GEzj2rpM7hjwbhwPD9IW8x6SuhjQVcXCeS7spio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNz8ivPaAQaym6sTtYrnCjoLyAkpf73jsqLFGH03mezzNyXCt9ngqYyGjz4pUNhRO38GbKaZcs1IsnPYCwcWB+dI0UfP0M1jD3Eqit1vLbM0m9NeVnqI1cT0y7ZMQaY9FnNZEhHvC6bkhfqxuLfA7qdyPVbD1kgzfuRur47Cjio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=NiNXyOJI; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="NiNXyOJI"
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8C6713F29B
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 23:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781133172;
	bh=UCic9KMxpYHNL6NobDAMx1YPJ6MKfbdc57XVi/nT2wQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=NiNXyOJI00ZakGDsF9ObZ1M95qa+eHcof0LEMuV47fe8xSi8n9bxmSknVrf+Yk29D
	 +h/MUw05GID/XU8H3uOM/z0a0ZUucpwgUBvzLik1hvGlX0OdCMXQlXQ8v8Yz1XBo+L
	 zx3HCF6s4jPioiAAweO46f5ekAUgCY3wpiYtQK3ItXJP1hD5BRg7YjP7kYe923FNpI
	 49PVceF84lW66f6StLiyy7AKG/fss2vnjiD1ILz5MA7n+uq/n9LLa9uHQYX7k0HScv
	 XIEmKAeVS0QE0iEZme2sOWmqyO0nHI0z2PLMV7qtBu6ADYnqT8JjgQ2I6HHEjnq+Lu
	 Fx1XxypfjhZ2U6Fe57TojAPe65+e6dd65Ml6wkvSVVdFZz9kjzzY0kulPCAtJGANJe
	 ho55g0oRqJztcT4FP3t8Twdym2+p4TAd6ixgw0NHNJdE7Q9JCR1jB6HRPMaR3rsYGa
	 pIwpEj+dJp0m+IxqMtZsjmwnvnqX/hWn+aYab3kZIzZlLUYQYXC8gTKtk/fV+Hdms5
	 i3ZTcO3R0Z+QprrYJJ/MNFFuBAVjsfpCMkaD/Gi503Eb0zJNWCl9y08+MlsWDKKXzJ
	 h0/8OaU7cYLV9rGNo00c0voCJjUPgygEIsdind7YqvRbcO02F4tFgeKASB8cxZiwxn
	 tMfHKvl90XNZFPzXblzMlb4Q=
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c2b64850easo31702715ad.1
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jun 2026 16:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781133171; x=1781737971;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCic9KMxpYHNL6NobDAMx1YPJ6MKfbdc57XVi/nT2wQ=;
        b=RoB7EV75Mzhj6rzT4DhKEmf/JUu9L4VdO+x0NS6ZGgGpypNwHb8WxSzGRGWyjUwnpd
         Vqgq0x7DX5+D1l2Y1LRCmOTtQ6dxPSeKurVLy4DWnPGd7ajAdGfwavFNk2AaQzYVrXt/
         UAiTcBrO7vkYtovDRIF9Iz9swuKv5H7PlF5EtU8MgPD8c06A3D0BD2qDJR/gbAYGkgzE
         qJ5SdXKbyNQE322+/g8RSGSktZCplu5sItzgtHs8PX/JW7oMGw9WpyYHIGQg1FPgZzGw
         hYltRixq2eBMU3IOvHbSfornBvVf6CDAUftXxmhCW3FH/5saq/1JcCWv4MWtXJ9fmeZi
         F7FQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Z5vFp5nmikmPVI+UASsiT/CX2Yif1KZHbj05F3L3t55640XdwFkry2gDvS5f99LVe3BRrdNUbXg8KE3nkU5+lfuMlNhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xVTfdudxuQvZ5PBmTX2f6Wfh6QpwlMR9LppIyNo95COi/l6Q
	9WXqOKUFl3w0JRsuciUzrxU8xbyzw1XCD85oxj8tB9924mfVnwZFKdor8zPVV0vBs4sKXTRdy+1
	WomzvpkjLR7hEo+UF0GQSODXBwdGWsy271k4pw9BgXuxKsrvI8HcGUO0UULIzdWhYTfClb1h0lg
	9NgV29mB1yEO6rlPhItg==
X-Gm-Gg: Acq92OELxjb2pk/xuK3rQEG0flp+kOYVq2mhfx1yxKGMC65RxSAJHX1O2Lfd5eIBdwz
	xH61CN8x9RPuRyWdaGWknfTStEJR5YT0lunwdgfpY7eAnoLp8oeYdp/PVVRX3ZWIfjqqYzmRq5q
	kI546s3FfoKvlMW9hynbBLh1ZUb7duHH8sPSbAdr67sMtvNgflri7K7FkCox2luZLC9HITnH1Wk
	pM5pbvz8hm6dMCgQmleTOXKHt8GEugCrhuH9KayHS1dto1I4hz06dzC3w/F5H1uI6WyqylAWJCf
	EUGHWSXdm3BLGkGCU3zGWVhGlbWmVE+sUt75xxidGsBfhosGVP9hRUmWeISCK72X02b1E9FCK8G
	hM2kSUoF3LLdmwy9et804TY9PfBctjz7HhiWeJJw9kAsY0Oc=
X-Received: by 2002:a17:903:1b48:b0:2bf:2114:ecbe with SMTP id d9443c01a7336-2c2f4208cffmr755715ad.23.1781133171183;
        Wed, 10 Jun 2026 16:12:51 -0700 (PDT)
X-Received: by 2002:a17:903:1b48:b0:2bf:2114:ecbe with SMTP id d9443c01a7336-2c2f4208cffmr755475ad.23.1781133170789;
        Wed, 10 Jun 2026 16:12:50 -0700 (PDT)
Received: from [192.168.192.71] ([50.47.147.90])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2c164f6d389sm245839845ad.16.2026.06.10.16.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 16:12:50 -0700 (PDT)
Message-ID: <9ae61d4b-55fe-43be-87b5-a7f6217621e1@canonical.com>
Date: Wed, 10 Jun 2026 16:12:49 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] apparmor: add support loading per permission tagging
To: Dan Carpenter <error27@gmail.com>
Cc: apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
References: <adjOGC9qtr_9XkgS@stanley.mountain>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <adjOGC9qtr_9XkgS@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/26 03:16, Dan Carpenter wrote:
> Hello John Johansen,
> 
> Commit 3d28e2397af7 ("apparmor: add support loading per permission
> tagging") from Apr 1, 2025 (linux-next), leads to the following
> Smatch static checker warning:
> 
> 	security/apparmor/policy_unpack.c:883 unpack_tags()
> 	warn: missing error code 'error'
> 

Sorry for late reply, I am slowly working through the backlog
A managed to get a fix for this into 7.1

72971e6f745ad apparmor: fix unpack_tags to properly return error in failure cases

thanks
john


> security/apparmor/policy_unpack.c
>      852 static int unpack_tags(struct aa_ext *e, struct aa_tags_struct *tags,
>      853         const char **info)
>      854 {
>      855         int error = -EPROTO;
>      856         void *pos = e->pos;
>      857
>      858         AA_BUG(!tags);
>      859         /* policy tags are optional */
>      860         if (aa_unpack_nameX(e, AA_STRUCT, "tags")) {
>      861                 u32 version;
>      862
>      863                 if (!aa_unpack_u32(e, &version, "version") || version != 1) {
>      864                         *info = "invalid tags version";
>      865                         goto fail_reset;
>      866                 }
>      867                 error = unpack_strs_table(e, "strs", true, &tags->strs);
>      868                 if (error) {
>      869                         *info = "failed to unpack profile tag.strs";
>      870                         goto fail;
>      871                 }
>      872                 error = unpack_tag_headers(e, tags);
>      873                 if (error) {
>      874                         *info = "failed to unpack profile tag.headers";
>      875                         goto fail;
>      876                 }
>      877                 error = unpack_tagsets(e, tags);
>      878                 if (error) {
>      879                         *info = "failed to unpack profile tag.sets";
>      880                         goto fail;
>      881                 }
>      882                 if (!aa_unpack_nameX(e, AA_STRUCTEND, NULL))
> --> 883                         goto fail;
> 
> set the error code here
> 
>      884
>      885                 if (!verify_tags(tags, info))
>      886                         goto fail;
> 
> and here
> 
>      887         }
>      888
>      889         return 0;
>      890
>      891 fail:
>      892         aa_destroy_tags(tags);
>      893 fail_reset:
>      894         e->pos = pos;
>      895         return error;
>      896 }
> 
> This email is a free service from the Smatch-CI project [smatch.sf.net].
> 
> regards,
> dan carpenter

