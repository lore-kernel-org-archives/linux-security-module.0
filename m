Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E4C1EA80
	for <linux-security-module@vger.kernel.org>; Sun,  5 Jan 2025 01:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736040233; cv=none; b=X0xCSBbbipr8dDqIAnw7L0awZOOoL1LoKs3lVtPrhK7DKAAHxUboREBY7QhJdi2/RqZ9EjNSn3vx13sIRpanq6nH62qQioXd6dBskNjch+JsDVrPSgfhNgb61IiYCQRe/80Wfdce5cU4PWtqQRf4lQWPQOJjY/mSHGlvddjLxA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736040233; c=relaxed/simple;
	bh=NgbM1kgICYJkniHR12jyNN34V8S31mdefZWKKrJmgP4=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=bWgPtmGbTxeFubJbTiTvkUald5odx4sT7zreGGQg4f5yrt+S44HBuVtwnW2yV0lUACSz8jXLlItZpbvXmcQhgt7xMk1E/3Fkv5ns+QYOWQYsPDnRYb2lAZordiLdlEy61Bf/lKrlufUZjczAqdMuWhu5Khtbr+RzdtdACe0Q0Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q54T68i+; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q54T68i+"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467a3f1e667so78273991cf.0
        for <linux-security-module@vger.kernel.org>; Sat, 04 Jan 2025 17:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736040229; x=1736645029; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxMgtgH324ptRSfJuMXT0SPkpytX5VIj9J4ESLVqwIA=;
        b=Q54T68i+BR9hERYTkJkXV7Ddt1XGGNI40LfbijMVzimIIUNDEfKZlLd2j9pekVUBJ+
         pHUtY/yzjfXGLBD8OkFSk+/kcNzBYN3IjUix8lIZxKYEAzF2mxCGSOY6NH8Uvh34Ihvl
         YKjKguf74UkXJ1rNOMcF42Utpmx67WDJYEoQIRbtmarJbU+1zmCShIsVqKzKaj82u/D6
         QCw7VmWi2yuZ9RmrlaT65VKTJk6huztgHkAXZrbZmfl1Scj8ozO2SaRrL9Wzpms3GrhB
         Oc0zpjdqQUMlEZz02PtAMlaGUnrsldMXMzr3dyS1wRuE+cA7Ukn+bqNL3JrahGRPVKoI
         6KsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736040229; x=1736645029;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TxMgtgH324ptRSfJuMXT0SPkpytX5VIj9J4ESLVqwIA=;
        b=XNExHbeDQh7or0vsAt8OPV66znvQjvxezrQg0VBqMpMGXRXWH2vlzS6ApePSS9p7wL
         6v+PHY/xywO78LRiXMSHJVZAWeIXixqdWfegP0CA28ZG2CiC5VyPtbTGGrvnEwZ/g9Ak
         cEEI0DuCzEHmWT2m3rcAqPWpbQ1OmEBjFHAmIwJKCKh2/agRuxL4HDZN8Z9GVDfGIA7M
         ajf4hNpLK8TxiFMTg4h1xh8HX/jKt21d5OdasDCdmA0R3UA/5cEsRBCjUCxwHwxg+aFY
         jrwwW1ENbL96dPc8g9sKIl4XROJD2JLIKZdlIXs/xg8GgxDW2LAQkQU7nPR0dfsvtS1Z
         umcw==
X-Forwarded-Encrypted: i=1; AJvYcCV7DFhCFXb207MidSMctShfm9BPNzLb4BEt6bgYF7ubNbKC3EwAybxchq9aHQsmxLuYy5I1EgTjfFDVVPC/KoISL7B+waY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJE/2WaCIdDyefgaZbGabczqC4SrdYA6hrAov/kIwbRurfJaZM
	mDISSvb3cD/bHiqJWag0neImEU/BTrUgKgd48ew/AI7mCEYaHOFM4RIpV4cdRA==
X-Gm-Gg: ASbGncuH6r/WyK87154eD0idxvwzAqdmYmlYQx7F+PcgNgRgUK/PfFhhTKtv63BJafh
	crqWy8vY0nrZWtZgEDvkEyH6rKVlpkCq0ptd7IwNMQpmzBGycxVqIPA7jY/a8NAah5UoIVUipDA
	q/t2JXh8Mc08YHsxiP8qcMuADS/X5lUJq3JlQDll5qK5L/4yYDxKc2zou5GEeIDHW4bsZRG9RO3
	nft6SgMdf1jX7wzITTXdQQBdJNuNYofYDf3WFqeSIt6BsMsv3I=
X-Google-Smtp-Source: AGHT+IFdk+ZliRwQLXV7AXBiqpq1OufmuvXYdjN7bKWLAEyGOOimSW/Kxj7uTQosuVb0lCFRfFQeJQ==
X-Received: by 2002:ac8:5dce:0:b0:466:8819:6fa5 with SMTP id d75a77b69052e-46a4a8ccab3mr868889231cf.15.1736040229571;
        Sat, 04 Jan 2025 17:23:49 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a6f8d1609sm127874061cf.64.2025.01.04.17.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 17:23:49 -0800 (PST)
Date: Sat, 04 Jan 2025 20:23:48 -0500
Message-ID: <382de732ebaa88fe89e2c36b9216df57@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250104_1133/pstg-lib:20250104_1133/pstg-pwork:20250104_1133
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Eric Paris <eparis@redhat.com>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Ben Scarlato <akhna@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Charles Zaffery <czaffery@roblox.com>, Francis Laniel <flaniel@linux.microsoft.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@google.com>, Kees Cook <kees@kernel.org>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Phil Sutter <phil@nwl.cc>, Praveen K Paladugu <prapal@linux.microsoft.com>, Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, Song Liu <song@kernel.org>, Tahera Fahimi <fahimitahera@gmail.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/23] lsm: Add audit_log_lsm_data() helper
References: <20241122143353.59367-3-mic@digikod.net>
In-Reply-To: <20241122143353.59367-3-mic@digikod.net>

On Nov 22, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Extract code from dump_common_audit_data() into the audit_log_lsm_data()
> helper. This helps reuse common LSM audit data while not abusing
> AUDIT_AVC records because of the common_lsm_audit() helper.
> 
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241122143353.59367-3-mic@digikod.net
> ---
> Changes since v1:
> - Fix commit message (spotted by Paul).
> - Constify dump_common_audit_data()'s and audit_log_lsm_data()'s "a"
>   argument.
> - Fix build without CONFIG_NET: see previous patch.
> ---
>  include/linux/lsm_audit.h |  8 ++++++++
>  security/lsm_audit.c      | 27 ++++++++++++++++++---------
>  2 files changed, 26 insertions(+), 9 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
