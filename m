Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B883A267725
	for <linux-security-module@vger.kernel.org>; Thu, 13 Mar 2025 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868986; cv=none; b=RIk1WKdvHRMW90zSpoMWZYHVe4coYeCamw8XbydyqBgSUG2i3WSK66NKSLPPQ/6M8k9jZsgDRD9ZvO89YQ64o86elb4Xgtvkbsgc3CaAY4FceQAgHjeJEQJSNbtZF8a481e3BSgPz+GBKFBOlqRIMVuZcn1KOUD1w3jLt0bJhg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868986; c=relaxed/simple;
	bh=1g+NyktzSKK2XkKOy3k13nywcL9Mhib0LiUglpwfgZw=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=A4afzzsHUwLk/Y8NZigZYUM18OabACV/MCkfgZ5D0UdILutk7iygJAWNS+IKfVpZV0Vw5muzy9u2Jxh1cy9kwURRq0SwXxmFRSUH+7pRtYfqaq0J8O3sziyDJuJbpjQCoiF0HSfbfrcWXtCKI3ogYn2KUdKzhKStnot/fcgN0XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CQWub/lC; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CQWub/lC"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8fca43972so8659686d6.1
        for <linux-security-module@vger.kernel.org>; Thu, 13 Mar 2025 05:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741868982; x=1742473782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Zwf41u2oqw87EX3fkunUasMCQRwAQQeTNbOgyP9FzA=;
        b=CQWub/lC8wNKB1Yhwx5NObbw85YNuo9VstX4QF7oFij3y04I4Ugh+rPvM188+fNxux
         mJwhLF/AAjVpSEo+4QeZCQpxSTqlodQNJHsTrmSvAiQe5Usfrp8q/polQIRVqYyCjMBA
         FrL1OxfapIpq9Bbn7F0kXk7Uwab2MmbFLowUAhdl/VPv+rs+2Bm4a5Hg4G+2f8dmJUUC
         IBQvwMVxy/e1w3SV7cOF3wM6ba+iW9/zOVojPMYumqAvpWsbHvYf4Rh0Yu87z8+nl7PQ
         7LHuuchejJduzP5pjXxYV2vdfHRX4WTFaSL6cdYWvGC3RCAqvRHIzcZQV4Jkxi5NnT6W
         4x6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741868982; x=1742473782;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Zwf41u2oqw87EX3fkunUasMCQRwAQQeTNbOgyP9FzA=;
        b=BOsn/rpwtPhAbQg3qU+vhgNkO3PmqR/NVl1oTOCtrcU1MyhtqjQKDgOavvRnrPaCBi
         49TxXKgbFVvGW+q/C9UAqoBS2O8IUszN4Z8Nj/XNUuIPMPVgxVqcyvh8SXqiLDIjzbLu
         uPqiyXoGAdjSBwudoYMnF8Kfhft5dsPajSbX6ZEpBRUoU5g9I3LXdTfJ4yPv+uIUGGsu
         hPN9J1LKznf0J+u1rQMzzkYtQcMery92FzdHpzoIffWY25MaobxndTioJeLdxGgY6BnR
         gKbzicTmRMPu5JtzbmG76fS/YJNTxahsmy+CMQAU82aNg/OoivxCLZHaYRw+gx3xziDG
         9byA==
X-Forwarded-Encrypted: i=1; AJvYcCUKR9SfBjtSpeKJEWOCwoSt9LQ6QNaOvv9CWWyjH6rWQjrO6qmN5hHZVOAFfRaRjrxAnO68WuxIGQM2NcF+cfvBuJMeKi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr9/MClnC3FMHtNuyFdVGtwLqT/ss6ukKf24uoC/u0Bp2bo8k1
	Jjc3XI8mF9+Z8LPSKX82b/HDNtJ7GNAkBhwxS7yxRQyIG9KiST4FIU0hpPO+MA==
X-Gm-Gg: ASbGncsIVLbFr1x3qr2YOl2aNzj6LG4CQ5Jhmo107ofzut+o3p+QxFyjdQZbeafUMZq
	2O6QdeVaUJ0Q/MIrUudEx8ZqHZOIyfqEvU1AJMVFyLCAYxCm8GsDO5qInuTqA3g0ADQ8TWs/k1R
	76iPr61kAslcutgOp16coHQyiiFji/lJfnilMgqjDBjco4fn4+eAHBti8ZawGX5QYoVAzC/RSH+
	cU+AGLlrx0dbt7V1M/OJsw3k5RmWASCVus9w1XKRseMWiPZ/p8QDb5x2Gkftq8sISOwSGw18fDc
	RKZmngumuuXsw7L6PsWVqtzv2niKKB4JD49YotfvBfHp8hcIcqAERnGXfjVJ+HcyyGAiAgbwGBI
	jAdHZ+r72RvXQ47LuJlE=
X-Google-Smtp-Source: AGHT+IFnv2N7W3t0ayHxjjtCyn9mUUoe/Hxh3K5QKhmpW8fJk7aFYPPODamWfDzX3U1KP5rz9GLzbQ==
X-Received: by 2002:ad4:4eed:0:b0:6e8:9957:e705 with SMTP id 6a1803df08f44-6e9006752e0mr464948326d6.34.1741868982415;
        Thu, 13 Mar 2025 05:29:42 -0700 (PDT)
Received: from [192.168.7.16] (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24eabesm8979316d6.67.2025.03.13.05.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 05:29:42 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, <eparis@redhat.com>, <linux-security-module@vger.kernel.org>, <audit@vger.kernel.org>
CC: <jmorris@namei.org>, <serge@hallyn.com>, <keescook@chromium.org>, <john.johansen@canonical.com>, <penguin-kernel@i-love.sakura.ne.jp>, <stephen.smalley.work@gmail.com>, <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>
Date: Thu, 13 Mar 2025 08:29:36 -0400
Message-ID: <1958f7b4780.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <5ea749e38c39e783741bdd0491a1338d@paul-moore.com>
References: <20250307183701.16970-5-casey@schaufler-ca.com>
 <5ea749e38c39e783741bdd0491a1338d@paul-moore.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH v2 4/6] Audit: Add record for multiple task security contexts
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit


On March 12, 2025 7:51:36 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mar  7, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:

...

>
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 540894695c4b..79a9bf4a7cdd 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -168,6 +168,7 @@ struct lsm_prop {
>>
>> extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
>> extern u32 lsm_active_cnt;
>> +extern u32 lsm_subjctx_cnt;
>
> I'm not loving this.  More below, but I'd really like to hide some of
> this detail inside a LSM API/hook if possible.

Thinking more about this I think we can't go with a LSM_MAX_PROPS, or 
similar determined at build time since we have the ability to toggle LSMs 
at boot.  Need to think on this some more, but the answer is going to have 
to be a variable and not a #define.

The LSM init work I'm doing right now directly impacts this, and I'm in the 
final stages now. Let me see what looks reasonable and I'll get back to you.

--
paul-moore.com
>


