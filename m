Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A483422333A
	for <linux-security-module@vger.kernel.org>; Mon, 10 Mar 2025 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594856; cv=none; b=tRjMaZylqiAfpDUWzkkxI7+srr135DoNvxFgLlKVgutzfGzqGP/fMe/T+JVnWv2q92hqycWMEErOSe6PxouGGgAuM2SODML+9/ntgufXG47SpNt9TiOhg0FIWL6Ci97tCntgoMy744alkgPN8/e7LCglDgVXUqYtL2iRhELC8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594856; c=relaxed/simple;
	bh=a3XRq5SZMIxfZ+2Mgp5d2cHVY8T95QU6b1B4CIW7pak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PRTTiT6YxuTFgC6OuCmMJqbqiBTNedYaamvx0/oWkt1SyLJy1YA5r5nkW7+V9iZMzoWLla6Znq5InVBrNXEOZNQKH2/bAeUF4CGk3+G4Ux0aefEZTjxA77KoTDN+FwUfsTzXrjKOJMmxqrY21KNH+jcBDPUKG6cYC2m3Tmo2xIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cyaTK674; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cyaTK674"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3912baafc58so2754363f8f.1
        for <linux-security-module@vger.kernel.org>; Mon, 10 Mar 2025 01:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741594853; x=1742199653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/IRa+YB+4QLff7q5apAvMehk6zSiN1B98VZ8cSYC1R0=;
        b=cyaTK6740rbt95+uQsX5kzvSWPBI4uXp5z/vXsXqHXMs73rJSBuPA5DgvyA40T43IW
         7RS1D16MMYdk1NFt747ltEZwmyfGQ73SESIwQ0QfjbaiLF4lh5abAAYnNJeiqNiVFMzM
         Ncv7MEIdpD14lX12p/6/msmtYfw1YnSfrXvgydgxu6tm4ojjG5qFySXpTvGUiuJFHz5M
         xL/HSMAC3yEIPfExh2eXv7evcd1LrBys36ArdiPD1GHWEdUVtStDyh2WtTBUacvvgg8h
         DazycAcTQKU0Hn/7kxmGSr2JGP3SZ0DXzF3pT8m53MgHWiUVnM05x7yalcPCOUNNv7eh
         IGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741594853; x=1742199653;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IRa+YB+4QLff7q5apAvMehk6zSiN1B98VZ8cSYC1R0=;
        b=U4Hp6G+1Yz+suzSaYTsOSTMfwc+9PZk1E/49jIu7MaqLSWYJJO0Cj0vxEKWNumqx+S
         4uRC/Eo8VE9yp1L9MqBCZWUfeRZpRrutek7PIIDRIk3lEnWN6pO8OBJqazxi+i6qlkE/
         a8k0OI1JNDlOJMSR9r82Tjz6HkE0jXPPMSNQ9jCdFVcnYQE20a+czmwdvEzojcXLaU32
         nN6DaZoK9LJLOlkd+rP4gSvNWTXbSE/dJ8yBL+1c9eS5NK9mjbL/T+kU6SiTi7+xS+fp
         RV8F8oPl/r4VQRUqb5eWf5P5syGdwwXqTDVMhg5lR40PQuCJAIHaSyIxFWTChqgay6UD
         G7MQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3p8/eMlrRULMvROxrHtlmpa47i/6eWdM/ktFyF11vVKPzC6SmvwI1O8qAORJT0Mw5FcsIPfWWYTZPZ0Ih4K5q3soS7JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDJv7Br4tn5Lf9+uDPX2YP80RVDe+npb7rqvnhje3/iNkP0+jk
	E1DwAbPn4UWHXF53Tp+HnpYvewOR7HXiGMGj8OKpPSPqV5Cgm2Ntp5cqlFZeyGddDPXH06sOJIm
	u
X-Gm-Gg: ASbGnct3xovxYi4ItVRgimddtNIq/bihcv/AJo0rUksIuzu4Zj54u1ROXPETCQpuI29
	iKKAuWddg0Gjymvefe07GjAqLOdtZRMqVnWPjZ2elwf51dk4wiow6iyu6V46SnT6yxd+BJDmitE
	D6hFKj8CNVgp5XRultOFnsdPtZvMyHDV/F6n0qV4NMKHWdfBOe0fVtA7i6qqDlUJ3yBL09MtoKV
	PIqf3ge1yrqynPnxP7MTXHyO+qxkGpSU6a5Ud59NGe1q4Adrherlyy4qOmJmwF0pWC7qPQoxR8B
	N3xm/chXGrTaWjiquDY/UZe3uWIsQrEv9A6KvuRsKyOenivvOQ==
X-Google-Smtp-Source: AGHT+IEGATgu5VbdS6kbtg3c6tfuRZz15xP7b2oCeJs8qye1D0o8hlDPBidbACz+FOSKn4FK+JvF+A==
X-Received: by 2002:a5d:47a2:0:b0:391:12a5:3c95 with SMTP id ffacd0b85a97d-39132d6b98dmr7210587f8f.22.1741594852971;
        Mon, 10 Mar 2025 01:20:52 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfba87csm14444368f8f.17.2025.03.10.01.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:20:52 -0700 (PDT)
Date: Mon, 10 Mar 2025 11:20:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Casey Schaufler <casey@schaufler-ca.com>,
	paul@paul-moore.com, eparis@redhat.com,
	linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, jmorris@namei.org,
	serge@hallyn.com, keescook@chromium.org,
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH v2 6/6] Audit: Add record for multiple object contexts
Message-ID: <f57dc6f4-cc46-4a58-9525-1dfda105ea59@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307183701.16970-7-casey@schaufler-ca.com>

Hi Casey,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/Audit-Create-audit_stamp-structure/20250308-024950
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
patch link:    https://lore.kernel.org/r/20250307183701.16970-7-casey%40schaufler-ca.com
patch subject: [PATCH v2 6/6] Audit: Add record for multiple object contexts
config: powerpc64-randconfig-r073-20250309 (https://download.01.org/0day-ci/archive/20250310/202503100802.Dqju4qc5-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202503100802.Dqju4qc5-lkp@intel.com/

smatch warnings:
kernel/auditsc.c:1753 audit_log_exit() warn: if statement not indented

vim +1753 kernel/auditsc.c

e54dc2431d740a Amy Griffis        2007-03-29  1749  	for (aux = context->aux_pids; aux; aux = aux->next) {
e54dc2431d740a Amy Griffis        2007-03-29  1750  		struct audit_aux_data_pids *axs = (void *)aux;
e54dc2431d740a Amy Griffis        2007-03-29  1751  
e54dc2431d740a Amy Griffis        2007-03-29  1752  		for (i = 0; i < axs->pid_count; i++)
e54dc2431d740a Amy Griffis        2007-03-29 @1753  			if (audit_log_pid_context(context, axs->target_pid[i],
c2a7780efe37d0 Eric Paris         2008-01-07  1754  						  axs->target_auid[i],
c2a7780efe37d0 Eric Paris         2008-01-07  1755  						  axs->target_uid[i],
4746ec5b01ed07 Eric Paris         2008-01-08  1756  						  axs->target_sessionid[i],
13d826e564e2cc Casey Schaufler    2024-10-09  1757  						  &axs->target_ref[i],
c2a7780efe37d0 Eric Paris         2008-01-07  1758  						  axs->target_comm[i]))
e54dc2431d740a Amy Griffis        2007-03-29  1759  			call_panic = 1;

This should be indented another tab.

a5cb013da773a6 Al Viro            2007-03-20  1760  	}
a5cb013da773a6 Al Viro            2007-03-20  1761  
e54dc2431d740a Amy Griffis        2007-03-29  1762  	if (context->target_pid &&
e54dc2431d740a Amy Griffis        2007-03-29  1763  	    audit_log_pid_context(context, context->target_pid,
c2a7780efe37d0 Eric Paris         2008-01-07  1764  				  context->target_auid, context->target_uid,
4746ec5b01ed07 Eric Paris         2008-01-08  1765  				  context->target_sessionid,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

