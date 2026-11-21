Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795255716;
	b=SqrDBpuj5dOQZl5vk6xHFmADQCgmiT/NOpzj84t99A2ErFoMa69GXkbDe2x2h3kN1YvI
	 GqmAzoC9V5dJ0xNbwe2ktuSKXeIMBTXC20FhZG9OGoPWGmLiTs20dT5wIvAKKkF3tojGP
	 NP+CDjxlmJhYyzTNe69ZxyhqhkzmQTp7sYKea89hd6y8NpXrSM8JD6G0NPocjVbS+u2zV
	 WYfzo3p24iRIVGILZNXF6UBxQ7rjYjthZGS7xlQS/hrZ8SWh1vBL3qFJSEnBW+B6sP85X
	 N3ydp0R7RxSIJdPjBBD33420xOYE4zfdHhdQzQP0O3ktmviFO1ONqFb2WKjQHfGocbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795255716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M3bV9m2HMGmaCwO2iKbHIS6yi+cpxYoMn1NsouoZxXQ=;
	b=xL//hriQVpjr58b2gVW0kxw8x/mCkqS99VoWER71ugbic2auhYGuDj+qeXw9ROdenFVf
	 PBwSkbHaHyZ3oVtcsoS+GFoHcKsqf4gWBc7gtz+FlIyCpQX+rMOfUWEy640CHYh2zraxj
	 6Rvio5oJ5giDWMu926eHbmaOIMdetUbhW9KgUmLtmop1f/Fhobi6KRq/HGyHe8EQBfdxn
	 VLaG9E5ij7RJBUpUlYHkaCBbJxmOx+WHlG8WBfnzgYMHgsoSagSSv0jEkiAgvqk5jbGKT
	 Ayyri1P9YIuOEEcrn/fEKvceMdLElBU6gYVm5OlqyWzy106XwPkNCxVh8twoQHWJWww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vIjejmKx;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5FD606A325
	for <linux-security-module@vger.kernel.org>; Sat, 21 Nov 2026 10:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B5FD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vIjejmKx
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a210470b49so15327365e9.2
        for <linux-security-module@vger.kernel.org>; Sat, 21 Nov 2026 02:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795255715; x=1795860515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M3bV9m2HMGmaCwO2iKbHIS6yi+cpxYoMn1NsouoZxXQ=;
        b=vIjejmKx+awfWvtxbaiVdjBrjmiWjacQOxqPsZUI0CqGCDW0fuIiZRQXVDudTZGOTR
         gju5da9tDZjUyLhePRxMGltOIhPeBE99/TXalHSZJxFwMd2nSXfj/NxgATCe0LqtdlUl
         zckXDAqUVxmrB6H3i/aAMoJt1OqMT1zQ4QELOVm5EJMHsQHN6XIozmQwDAcFpaTGe1FJ
         kzBgVYJr/RM5r+BgnefB75i+A+nbhCubEQMkKMT+c012le4aDcLPSP1Tv3b/eFsVO8YK
         BrQMgijnUDiONQ99FXmLVxrum8UhLJCHLtkwN18C5zeOB1xqLvThyeguoPisJgItezGP
         A4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795255715; x=1795860515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M3bV9m2HMGmaCwO2iKbHIS6yi+cpxYoMn1NsouoZxXQ=;
        b=woiEN5EtbVe3kHkhVgFfpA4ZPlI510y0ocdRynByWbOJbnzTiaacMkN27jsoDWsbj/
         ywxgByj/kUlgD/Uoi4hHhahexoeXVh4Dq/1WkS7i//Ih2r/OgytJPST0z3562BHnEUj/
         ZGjg/pdb2iiZqTDPBFOroWnWrbFlQXncTS7NiQNlSXrJDqb5o0lzLdDPpbu0NcGg9Huh
         bEgVkQY2+pFjZADlA7kzMsLLdrKpZo9CPL5cFIGuD2gRq3VQVGa+WQ4HSTENY1JuA4Id
         kNvtKT++AL1swcsoGYO/Imgwt+rDzV4AXdEknR4Fe/KmqbiSQCUFv+XWbPayM+KGgL9x
         48yw==
X-Gm-Message-State: APuU4Z8pW56r/BgZDOwsv0XZTzkWjhT9n4eiF8lCSWVF8PDVDOkxxSwq
	puyUNmoyAwQk2pkfyisKEy5aOhEQ89CJHkQ2DHxZDUobWJ1u/PO90KLg
X-Gm-Gg: AZFdTZfdQn0DtPuAHotshL3KqSmiZWyl4KnQLLoZXfDUpZv2t5XBBMkXqm7VmD9Phh7
	bxdzSx7Lpbqvca8KGfIHZAMKupGQP/BQT3Uxh5/djJNZU73sHKLn/ZDh6njx8xgJgAzGZrDe/QP
	+EFn2IGoUCqFVC01ROUWwMb1M3HOvKnewLjiAlXnxe6bPov+lmjAD05G+G1aKl3JmSLoi3segWq
	O9Vwyde0JLdNSZPqHuREBLHdTyhSOBwKaIsNmn5Vgwr1WvMLmnRJ2YfEegXk8pgkQQeJm21krfd
	HYHa9OOYt3pEfgWHnSySAZtLH6gZ8pK00vWMoewutFCREOlXczIv2Zw0/0AtnNyv1NV+9gulM5f
	hzpJbmPJG6bo6wIyH97Uj6zTQU6dpALKqrbU6Kirv3lgRVW9NGo01fvFAaBmhdTd2MPLidhKXge
	oxrmSbHiQvMIBtUbHI8kW1U1n3f4uRDFMUcoV+1FgF+Xt7VNEsaZPbhYNzoQTWKpOI2NUQ/el+v
	y83evecoJuD3pozQacMvhftto0+2tceN30fouJDyGuikH3l3WldYSmYAjaiWTga4RvxLUDbxKcr
	xpqRjocmPyaEFHYj+YaXiuVFDy3Rr4oLGQPYeymizHDXBNmjN2czimazq+p0SEeB7TL3eqNL619
	0gBCa1JOUda2Vym4ffMHi91e+sF76vr8OdFAcXeRakm3PuePtDbE=
X-Received: by 2002:a05:600c:3b8a:b0:4a3:59c9:a754 with SMTP id 5b1f17b1804b1-4bb8892da25mr128310005e9.22.1795255714723;
        Sat, 21 Nov 2026 02:08:34 -0800 (PST)
Received: from DESKTOP-IR7J1S9.localdomain ([197.118.31.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906635c7sm44631505e9.2.2026.11.21.02.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 02:08:34 -0800 (PST)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH v2] lsm: don't call d_path() when current->fs is NULL
Date: Sat, 21 Nov 2026 11:08:32 +0100
Message-ID: <20261121100832.499-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <481c20b898f003247763475ef417c321@paul-moore.com>
References: <481c20b898f003247763475ef417c321@paul-moore.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Paul,
Thanks for the reply,

>  static void audit_log_lsm_path(ab, inode, path)
>  {
>    if (current->fs)
>      audit_log_d_path(...);
>    else if (inode)
>      audit_log_lsm_inode(ab, inode)
>    else
>      audit_log_format(ab, " path=?");
>  }

I got your intention in your v1's reply, but i think that changes the current behaviour,
if current->fs is not NULL, then this would only log path, without inode, whereas current
code for example here:

case LSM_AUDIT_DATA_PATH: {
	struct inode *inode;

	audit_log_d_path(ab, " path=", &a->u.path);

	inode = d_backing_inode(a->u.path.dentry);
	if (inode) {
		audit_log_format(ab, " dev=");
		audit_log_untrustedstring(ab, inode->i_sb->s_id);
		audit_log_format(ab, " ino=%llu", inode->i_ino);
	}
	break;
}

if path is logged, and most probably also inode, and your suggested change only logs one of them,
Is that intentional, or am i not getting something right?
In either case, i would happily send v3 with suggested change.

Cordially,
