Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047301D619F
	for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2024 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734390806; cv=none; b=scrgJ8/H2JvltlOdidLhFg4imLuzF97bcMi8QSwWLBbb3uhRur48Z0iq//y0UqsUzL6HbtTBIBu7XO4/ATtq+Scbt0Eofe8GClzqiFGEP1L/YhgXyuXzX9l1aCCfOU7+uznmxVYXIameEAqXqan5rjBN+sYZoWrncL8jNL5Qf8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734390806; c=relaxed/simple;
	bh=IOgGM2w7pk3oigV1gqLUmR9Qqpa9O/Il6zfGw3fe3jI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TSN+UFXm70/AqGqWJNke860x79g6S7HRy/kCMZi4DQBkq7f+9W2R9NelPMyJGJ6B7LZMrogoW8OxdRuwTimVbOBcxXusAtHlQd5dG4c582XdSmw6T1qNa+F2W0uAipn3cpCSS6SnSHWv2wcNdEnNAIiUr8e5tzc49cR4hZqRk9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Eytt7KwO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Eytt7KwO"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2162c0f6a39so50346135ad.0
        for <linux-security-module@vger.kernel.org>; Mon, 16 Dec 2024 15:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734390804; x=1734995604; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Cbp0zEgt8sYGgGttOagenj605vUWFx5sipZ2Yl2U3s=;
        b=Eytt7KwO0WU2hyUIdW/6GWYKKe++eJXTFSyWcq8AVT9BM8fYi87jMhv+4jfU4DW/SM
         hyLHneNQV0xzTXpk3yPCrpVdUrEIFzxcnMLVAN8Seik2D5kEC5bk9Qp4NYt2kqf1VUOs
         AztXLshVs0dm5EEM+UKBfE25F8xJF5lP6qP9kmtIg8d83NTQRbWfK2O4Ky0A1mdIva3s
         FbBBy/+qT1gBazRFleWvObp37aF/olvT93vmxU41bjTaTJ1m/YG5UY89kW8JloxQB4sv
         q4Aik/spGo3H7zJuXsuJTNyQjRm4ZabM4mdtwH7f74EH68eGaQzuJCQ1L3bNQpnOX0lH
         kd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734390804; x=1734995604;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Cbp0zEgt8sYGgGttOagenj605vUWFx5sipZ2Yl2U3s=;
        b=SaxNygYSOyENRv9PEKS23a8wKLCn9TE+HutqH3ujfG9q7sgMRvq9zap/0eI5I1KDG3
         519zcYBR9xtikJUI+b821EygdT1NYRxGq2TBSZqg1DiztgdbcAne/5SnrJBYyBLGCRCn
         vVEPMoTsujlGnP+C9ys3Ru3vjlnafPZdgmDOFo8R4VARMoJYGx5wNFxGxtLT2Onm77YL
         +aojw8fCLtS0k0T4dEDBeIOdle7rRzEztDMg+nD259M5DchdEMHJfxNmGR8es0+M8Nvb
         /HTgswewjKo40jdq5K801VDuLIbbP+Twnxzrx6Mw54r/aqqaQAt5iV4ftU+B0YSZJ5Bf
         PCHw==
X-Forwarded-Encrypted: i=1; AJvYcCXxIOVhsGnQmUs7OL16vpL1uot0kCa0hnlE6hUtHqwHPKVLA8GPhi50bUN9D/DoEXbh6LFnRzPBoj1JFOyzisG0VX6EBsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPgGp7wVRPN82/GTUN7/z0/gsB2aRZYWfM9TG5gXWwIjLO9Zlc
	OieANZ9bdP2jrbtuphlxVxvNz6eIoKSTFOWSTQ9BwL0UuNhHxGIrlB6s0AE6cjE=
X-Gm-Gg: ASbGncvYe7aMKfhmZQb0SbyoJ2g48H6zfsc2s7Tlx0YguiRe3HJYXOHxvanpChmA672
	Z7vx73QBHiVrT7sD7zQMtC73jwlxT7y+nr2timVHuP+STlH/GfwavG0Q1dikXrwuOEgZ7+HG5WM
	Hih7OEXjW3e2Y5WhB+cVZkyYBw/kqpcZ3Tb5CT7poqlMllOHoCi0ApkYb2DsR2xGo7fBRBVZzhc
	JJqDKJWZayGysNFkfNoFpdvnIN1DWGbKJRabAJNRhgDgpKZhr+4yCjtghO0xvaKSt6q4+ih
X-Google-Smtp-Source: AGHT+IFjshciKlmIzBIB1jw3LAR8ZYMAQPyyhOAHw8JXPxmnDCkeL3I1RpqctkebF7xjVj+9QrljiQ==
X-Received: by 2002:a17:902:e94d:b0:215:b18d:ca with SMTP id d9443c01a7336-218c9262d3fmr19286865ad.18.1734390804203;
        Mon, 16 Dec 2024 15:13:24 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcc47bsm48333255ad.63.2024.12.16.15.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 15:13:23 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/2] perf: tests: Fix object code reading test for riscv
Date: Mon, 16 Dec 2024 15:12:50 -0800
Message-Id: <20241216-perf_fix_riscv_obj_reading-v1-0-b75962660a9b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPKzYGcC/x3MQQqAIBBA0avErBNyLIiuEiFqY00LixEikO6et
 Hzw+QUyCVOGqSkgdHPmM1XotoGwu7SR4rUasMNeozbqIok28mOFc7jt6Q8r5FZOmwrOxw49mTA
 OUAeXUA3/+by87wdZlscZbAAAAA==
X-Change-ID: 20241213-perf_fix_riscv_obj_reading-cabf02be3c85
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Nelson Chu <nelson@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-riscv@lists.infradead.org, llvm@lists.linux.dev, 
 linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=IOgGM2w7pk3oigV1gqLUmR9Qqpa9O/Il6zfGw3fe3jI=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rCFo5+3e1tQisqpS6cac/wyM1MmJaWySK9PGtBBvOv0
 6Xbun91lLIwiHEwyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMBG+LEaGb7e2ZHT+jXg/4T8D
 c2X1sxcK2mW1O46Jy13fG73kPPv5XEaGxZM1Cxg2/bUOU7Tlnu+i9MlYSu3ZjWSraXInZx/vuze
 VAwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

There was a breaking change to binutils objdump that causes partial
instructions to no longer be dumped. This behavior is different from
what the "Object code reading" test expects. Add a Kconfig variable that
checks the version of objdump and conditionally enables the perf test
fix for riscv objdump versions effected by this issue.

A binutils patch has been sent as well to fix this in objdump [1].

Link:
https://sourceware.org/pipermail/binutils/2024-December/138139.html [1]

To: 

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Charlie Jenkins (2):
      kbuild: Check version of objdump
      tools: perf: tests: Fix code reading for riscv

 arch/riscv/Kconfig              |  5 +++
 init/Kconfig                    | 10 ++++++
 scripts/Kconfig.include         |  6 ++++
 scripts/objdump-version.sh      | 69 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/code-reading.c | 17 +++++++++-
 5 files changed, 106 insertions(+), 1 deletion(-)
---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241213-perf_fix_riscv_obj_reading-cabf02be3c85
-- 
- Charlie

