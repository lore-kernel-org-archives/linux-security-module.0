Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919D923D7E6
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766951324; cv=none; b=iUbcpBLS7wjmDEWVJWaEzbW9CC4i4KCaJEhy56hbzWMXAMh/8EM9q6+jqWjqoD+MVZGrIgJeOpZHR/kV0LSDpD+Ylxx+8EyrmV0i6SOV4iZipQZQ5r8LPo5kanGEMMEPWoFy4eWZ6ryOsp/FPYIjeHpPOr/j/v9GhYPP7yGlSnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766951324; c=relaxed/simple;
	bh=T9YN8hfLvxHGnz3PBErAoCE4gWgWoAu3FAZqPFkHTzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKYJkrGgXtu9bRw4WC+Adq6qiRX8xZkjz3UXxASqfY3KM8PFrJxsorboB8of89SJ3jHryKe3A9PAP4NnTIuHm3mx8lCbmzZzjWX1Qq3PYVP/c+GWbKdNzX5JGTMh4Ol8I1WBcXS7K9/fzkFitDdKXL3PBxgloa87uFgrNI6jIws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERj1H81g; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERj1H81g"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a09d981507so62243195ad.1
        for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 11:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766951322; x=1767556122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9YN8hfLvxHGnz3PBErAoCE4gWgWoAu3FAZqPFkHTzw=;
        b=ERj1H81glMbPRxJ387QyaNJgSlFGi3wDO1a3hFDOaigFUtmpoXMYL5smdkpBQqUbCW
         CcfKoqGIPziZwjIqqsxUH1HblrBwIA6Nq2THztM4wACzt7rlLiA/bpZar+MSDovPCEL8
         BwG4JXeGwbM+cKnYiFJKnwTvKR1Q792uHH2r5ES6sjmWuQC6qTeOnytxgAtVEAYhQSaR
         ttYSqe/SDZhuYWfcCEiS9db8of+pyB9YpfNQT7fopSW21LvQthbC5D3Vunc7EPDaj29b
         +BDskSlN3Sfhl1doDpSDAuha346oaMwcPUVPrkx3/9tiehX9Sqjk/BU4jpgMMm3iFaWd
         OmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766951322; x=1767556122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T9YN8hfLvxHGnz3PBErAoCE4gWgWoAu3FAZqPFkHTzw=;
        b=KCSkcV1+ZLt6ILBAMlbkpRiiJaUCTkwwmTm90UW/EYQoX5sOsvrDQqKdznH9p9HcxF
         5YorronmRCz8T2QuayXI0weXgxjqlsGRQo1MUfnOx43El7QZhJQl1oDvr7tCFaAu+KEg
         kYuMi7z7piOeSBWqm8Km1apeF91k6GqXp6sp1eFKIx7t+k0rNm6Bpg32mIR2mOxsvLIS
         xcJKQKYBogvQBMEMnGRmnI1BbcHYEa7I5P+z7uhFcqPK492x1sSoJKk78BQBghogIbvA
         Q2Wa3xYKn+i2gZmfGhrA2OrJ8CDXWVU70Vxnmdjd9K0BOBL6w665qF5kVrhX3c0XnbBO
         oZEA==
X-Gm-Message-State: AOJu0Yw/eHHIqwV9JgLrzbux80ENEgQud6rOKvXQSy6tFCKcVCPKjqxd
	5g28ORvgPnN9VzPwDYV6H8VCn/5PJZZgIGk72rbzoCZKQhYCu6Nn4HY/QHQek5JS
X-Gm-Gg: AY/fxX7U8p9HwB9yG/mxNWBjXnrYWbtSxo0sOBPn2VwXKclKabsCv0K7pwGVM9ClQdo
	O69naRDClUXzpe3Rf5aoOjR9DttuK6k0bTrgKuqaSRrXikh/pzz+1rqin9Pyp6qHSEnARYZnw1C
	kzft66NE4qapJuNmQ8owuqFSIBizQyMQiQgKX24OLOEuQ4D+PLn8IHuKaA5d62w008weSB4FvHp
	6fnRmCfw7qf6jRt1lmeCDPO/5r0h8ZUaXo8RWtpSNKCWZ/ad9hzjmDoi9GsSUSWZ2lbXdL7E60N
	5QJtoElilaISVyNSStkx+iNEJcHB/XcRaVLaP6C3tsDTfumlJpPJ6YAuDC6+vlv4rYbSxyK0/L5
	pjC/iQxx0gNXGm4Ek9CnBCrsWL9pgJF1OJAYNzszPXgWhpAR9zaHtlKqBuVfP5xEDWCEtKwM4MJ
	OaH6zs+kBOBenlIEoSet9GrZNoUZCO0wR0VeebcSn8A5Jl/liJXlo=
X-Google-Smtp-Source: AGHT+IE/Q45OlGKr25wtJKDnztih+hqs4pFsSnGiL/RvgP+xRq+SAvxB1+Z1rfCqgfZ54DooWAZBMQ==
X-Received: by 2002:a17:903:1585:b0:2a1:3769:1d02 with SMTP id d9443c01a7336-2a2f0cd3fe1mr249808975ad.12.1766951322307;
        Sun, 28 Dec 2025 11:48:42 -0800 (PST)
Received: from kailas.hsd1.or.comcast.net ([2601:1c2:982:6040::e14d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d776b2sm254282665ad.98.2025.12.28.11.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 11:48:41 -0800 (PST)
From: Ryan Foster <foster.ryan.r@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paul@paul-moore.com,
	serge@hallyn.com
Subject: Re: commoncap KUnit tests v4
Date: Sun, 28 Dec 2025 11:45:36 -0800
Message-ID: <20251228194838.32214-1-foster.ryan.r@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251204215610.148342-1-foster.ryan.r@gmail.com>
References: <20251204215610.148342-1-foster.ryan.r@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I've updated the patch after noticing the dependency on CONFIG_USER_NS=y

Thanks,
Ryan

