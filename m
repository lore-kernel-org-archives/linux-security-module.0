Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826537;
	b=QEn+SoRnS5WGheB/xyHtOIq02OZxUzZJMAyEnOQ5S50zTlGe0CW6ZcFziPnBh7ldxLcw
	 //FFLKTt5lt1BDGcxxj+yWcHlMrqyWOuXM4E8b7DtgGYstNMRGWu/UUbONIkEi7ZZVHle
	 airSQDhuwcUh9RtUQE/XLO/FC8w/asM3RiG0q+By44pydmkiVNaP5Au1wfI2vbW3rzXbT
	 a+3MvilWguS/LEeq6/3NIjbxKlbobKaxDN8Kzg5JXD0Ewzq2yh6WCA4gqG1HoaVm0njjs
	 USF8HaNzTzsgd50D/Iwd5zxDUjoqGLT5xFxxybQTER/4zBS/Y54K7fd7ZpVCLVcQ7NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=Y7qQA4iJ8bvsuMHrueNyP7nsWPHIAJZ27V2eF1EoO+w=;
	b=ZJnWpq7wtNkDu506ZffjBN+wTMTP35c1eIa4yk2pB4U9mAk+oz6IDfdzguGbBr+z+TvU
	 VZjnqVATRAl+ZXQBxMFZjTy/dFIZqPEcmd6JKZsz0HQVmSJgLxcodAbZTKmurvFOS5oPo
	 30Sy/HSP9SGWPwD0cBTwWp4TmE5P73iK0airx9jinif5y48ppvsY/EiRs+IPK214q6UqW
	 /MksO1RpdDlq1lBJXzOoDJvo+acrZUcbY+a757uJ5YFJlezdZCGNnzOhNpVF74A3HhW0J
	 JpLWibpDrEfhYUZqs8tF+F3KoGMsSmNjgBaxrCxW4h+2+yaYSRJMceT8zniu2S00MYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tCK+qSh7;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D686B607C0A2
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D686B607C0A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tCK+qSh7
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso9300815e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 13:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826535; x=1794431335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y7qQA4iJ8bvsuMHrueNyP7nsWPHIAJZ27V2eF1EoO+w=;
        b=tCK+qSh7U0Ie38Ckd0J8m8GPgrkpDTds3ChR6Mv8zezfM5a5WNdKJTl3RXMkps0TEY
         MpmFiAYXr5RBgooFn0Tkq94gK8tV3I1ZBWv6SpXovoAlFVyjez2M0wjaVHa9ixeK6Lmq
         bx3++ublClyuTJTPsutgG5iFtyU1kV+XBKJAtsv7enmH5vYNwNbCykZtWLyQhd1PzjFh
         yzXiOkDKx1v8UyUzuHpJ0iJhwAXm+K6r3lcDk0/bhuvOBqZq7zjgLIWCFW4R2NymR2ey
         Z4oFw+TaPoal+ruZ+FQqUHSAkMsxYTewGcVezdXu8TWNHZXKEawpTt5SQtOf2g6Y6oDp
         CI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826535; x=1794431335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y7qQA4iJ8bvsuMHrueNyP7nsWPHIAJZ27V2eF1EoO+w=;
        b=OUGlS3D8r8rGvU39EZXtwh0s0DPO+1eNfOgCRXJ8r/NAt9ZSJLdu5cAnjIapb7uqhk
         mjlzV4eqeaC9we0eU6CtE3LBwuSxtM8rInWtY+AD1pT/9jq+TVAowqcZT9fCszy6K9Wf
         p1mx2dJN7N+Mxsl1p1Bn/DwVxMWVmFSYfcdHQAFO3Dj3LBH1sz2qIbDpyZ1XzmZ/i5ml
         j2Lnj9O6G9p000VsF4x32twygjeogfci5mbe2Dq+nqMR5x1eKEv/J2EBwokR9DcIFImB
         vlLywNinyIcd9aZu9/5AWzvUUp/SccgxxzsJFJvDI97Gwa6uslNN9Zfgr9V1PPZKQJbT
         UwWQ==
X-Gm-Message-State: APuU4Z+VDblu1FiJipowBPuE2X78iuhLJHzgKjPsWXkUYvr9ikoIfkgV
	GvhXkaTBCnIPxNtVpYbMXopVkBBWcq4ykMvU0i26i95g6oUF6tFG2swx
X-Gm-Gg: AYBFou2nfJoyv6za8YEaeHy6wlifZBs+DYH5vIAYH/8yZ5F2niDJ2m77bSVv7kogpK+
	AL4C2BE4SNP6sFaUiwK9dYVH4/GYLjg/W1iG0sabBOwLauMF+SDWk3xnctDNuAzIpl7yN53txsk
	xlIz2Vyo6aaoWAz4Jh04BoEa9l4IMdbeS+wXEb3Bb0R4STZdb0A0t6+1XdaLXtg+d4P1uTbQ6+W
	EvsjbuVBTF4pkelMkehhuavMCAa3VcFZnt6DL5Us4jn1Z2PXaWSdMFGRZ33brjU6JMv1AHdcoFG
	jKS2IYp4RNKaU+Xi0a1SP+F5/Wht9mANwbP6x95oP+gMcf3ov9xOHybaawkaNyDAmgedITVrNew
	nQsiv8Bu68T30FuT2O8KrI1IyUSeHmAaZaEZ8+wzHGZYt5aTJiz7uEAFaXQtQ7/sLBQhvtvhsQN
	auid5frsleziK2Jqn0uucX+q1qt0NcaevTIhCbl0Cy95Oni3zj+/32H3SDYGQJcbHO2ygrxmWSa
	FKv6Kie50sXXGw9y5kCdeu/oKsyl16+2kH9PHuZcW8r0fBCm+suHRdN4z4a2j4HRsNQqazAr3RV
	RbOQCr/xUUUPLVx3xG74Cggbb9+Wq6LCd/IZsivS7Wop7hy1jJZfdQ==
X-Received: by 2002:a05:600c:8b64:b0:4a2:84c:52f3 with SMTP id 5b1f17b1804b1-4ac16fa21dcmr414738865e9.6.1793826535182;
        Wed, 04 Nov 2026 13:08:55 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b452cd020csm81378775e9.4.2026.11.04.13.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:08:54 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Wed, 04 Nov 2026 22:08:47 +0100
Subject: [PATCH v2 01/27] selftests/landlock: Propagate grandchild failures
 in unix_scoping
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261104-selftests-refactor-v2-1-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
In-Reply-To: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

scoped_vs_unscoped.unix_scoping starts a child process and a
grandchild process.  Add the missing check for the grandchild's exit
status and propagate it upwards.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/scoped_abstract_unix_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
index 5dc0debacb2a..e006dba61652 100644
--- a/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
+++ b/tools/testing/selftests/landlock/scoped_abstract_unix_test.c
@@ -608,6 +608,11 @@ TEST_F(scoped_vs_unscoped, unix_scoping)
 		ASSERT_EQ(grand_child, waitpid(grand_child, &status, 0));
 		EXPECT_EQ(0, close(stream_server_child));
 		EXPECT_EQ(0, close(dgram_server_child));
+
+		if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+		    WEXITSTATUS(status) != EXIT_SUCCESS)
+			_metadata->exit_code = KSFT_FAIL;
+		_exit(_metadata->exit_code);
 		return;
 	}
 	EXPECT_EQ(0, close(pipe_parent[0]));

-- 
2.56.0

