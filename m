Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90152FFDFC
	for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561345; cv=none; b=fjarcXH12DDm3ZC7IhO05NJDZdw/rUKQ9j0eZs8AxVJwQKoQySen0jACwCYuViaKinCK4jhmpNx3irUzskLdGvHeJAkPOER/zfaguecHrUb7FSppmZ0P2Nf/uSSxJIEuRxC8AIzcLTvyLYTtY09wSEtR0EL/z21SVmipYfnPKbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561345; c=relaxed/simple;
	bh=NkmEpXSuwuLhgk3lS0PQKXSpIu4CRN0uCwVXZNwYT+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=az9Ca8KjRZElCydrWE1oEpTx9AlDej9lkwd8e+Imqyb/z80hqDIf/U0pzGlrC3ShOzKwVWFgf/BXHfcHwJsU7kldkn6WDajrN0CtpY7nTuDBvVM4/8yS7uIwXYBUIUjaI3OUHXRcx/jE54g1/YkvLXWHrb8uKFekzhVzsg2AIxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYzGnCut; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYzGnCut"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763561341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sRv4gN6lbv1SmMMciAbtKT3jfXKjBM1qenldjai+GsI=;
	b=LYzGnCutMRmCN+j0zR7YLmFV6NcUCmLtFa132KlS9qkwDtyluqQsg6Jyhs9LLRPbra01oH
	3ll+1xYL3wMu23MTpkG7FB0aAJbK2ttTlFzIt1QuxPpAORrijj7F4aRdszBZOMp6NrjXuk
	H6m4CBc4vG6O77ZQPCaMz2QrgRMzq84=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-EcKs8lkNPOyT0xQ6Za0S8Q-1; Wed, 19 Nov 2025 09:09:00 -0500
X-MC-Unique: EcKs8lkNPOyT0xQ6Za0S8Q-1
X-Mimecast-MFC-AGG-ID: EcKs8lkNPOyT0xQ6Za0S8Q_1763561340
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297f3710070so136890895ad.2
        for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 06:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763561340; x=1764166140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRv4gN6lbv1SmMMciAbtKT3jfXKjBM1qenldjai+GsI=;
        b=vSkomMaraoJ/MYqWbDvRhBV2qAfiu8ULG++oEZhnvkFNxJSlGfOICTtUlzeplsL1vw
         66KdXbf0oempEWGFA3oHB77R5fJvE1AucSL429zGOUyailDm9oyLKjwr3YAOWr3yVzde
         pGf8j4j2Wg1u821x2NS0IW9/SklXAQLEnA9pHDdIsXyilMlHnLzLyHi6UtkCEQiKvRa7
         A3iPz4Jt7PgTMqzUW3dTGNuG3vGbQR5dMDyGLFYHLBxSLwZy5kLFnwOP2pasRv5vYQ4x
         PgtUEN9BpXV5lZHm/lj30QxYDyzfT4mWwb6qoGTbtwDDJKECSfys+Z7nzpABUCZX+6E3
         ZHQw==
X-Forwarded-Encrypted: i=1; AJvYcCUfYWDVUUVkvB9pfiwst74br/JwaHhM9B4pnHwAqHMNawPJl3UQAVJcPO1HPnYI4OPmdZGVF07cxMRef/A9QY7f1kAS4Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGForTfScIW6tJgx42Rs2pwO4dXvhlCKYIMyqOlFhvCrgwtLur
	dpC4jipdluP5k4xWwjwxntPq6nS7YQfYtSFjkivrX+4xBXYprZ/6tliju9P4F9WORYDPL1Ej490
	cJkveEV5EHk9i7izqv8PIKf2NZ5JirITK1NkoVOB/opWQ/RIJglly2DsadPEw0SE/xQrSfOjZ5Q
	/oJQ==
X-Gm-Gg: ASbGncs651dQ7o+vQLLtTiEAFnRUEQ/IxGd8hvmNeUoxNQjNhtxPxzmMfqhQ2LN1Vu0
	CsOWIsQV33+S+Tq+bbn3G3ENrjG2kEBg5aYQI9uKhDWrjcaNebWZtTCDs2OdXullVetAEq0eLAN
	6NhyppM353QGlxz73ME0fzD+2cA2VvXf5uvtLRDJ9W/Ckn7YRCwQDabLB73cE2rOYoS0yQZX+1H
	hrFsf8wPpolcrDxgBh/ExdOW5ZWtSzaqKS6TWTFJ87wnyPidP8rbVw4t18Sg29Ox/Tvt1ZYKh1J
	8EfGfU3apEuseQuPHVTggQwxsZ1ZNKCq7X3ZLndJ9iuDNYoO6CPN+6D5Oj0P74dJ+zkeI8C7+0N
	3
X-Received: by 2002:a17:902:dac5:b0:295:39d9:8971 with SMTP id d9443c01a7336-2986a6b8d39mr259786925ad.1.1763561339365;
        Wed, 19 Nov 2025 06:08:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoYZmE59xp6Ipi5eyc2g8cV1kiLGsM5qO/CIP4bd1FKcfYa3EkB3JPo0oIjCnqmz99Neumpg==
X-Received: by 2002:a17:902:dac5:b0:295:39d9:8971 with SMTP id d9443c01a7336-2986a6b8d39mr259786235ad.1.1763561338591;
        Wed, 19 Nov 2025 06:08:58 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c23487esm206193675ad.20.2025.11.19.06.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:08:58 -0800 (PST)
Date: Wed, 19 Nov 2025 22:05:50 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, Karel Srot <ksrot@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, "open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>
Subject: Re: [PATCH v3] ima: Access decompressed kernel module to verify
 appended signature
Message-ID: <yiwtnidayji53irhrowznu75ajedrsu6pwh7xzjplcyzmifz6u@7epealeg3ssa>
References: <20251031074016.1975356-1-coxu@redhat.com>
 <20251119034718.618008-1-coxu@redhat.com>
 <fc1d67e411ef53460517db4c03bdcf1b9d9f8a8f.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fc1d67e411ef53460517db4c03bdcf1b9d9f8a8f.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jxmTonKKtwQbnW4EWo6d6OIIZN3uPmRPX3dJ_dklgz8_1763561340
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Nov 19, 2025 at 08:29:22AM -0500, Mimi Zohar wrote:
>Hi Coiby,

Hi Mimi,

>
>On Wed, 2025-11-19 at 11:47 +0800, Coiby Xu wrote:
>> Currently, when in-kernel module decompression (CONFIG_MODULE_DECOMPRESS)
>> is enabled, IMA has no way to verify the appended module signature as it
>> can't decompress the module.
>>
>> Define a new kernel_read_file_id enumerate READING_MODULE_COMPRESSED so
>> IMA can know only to collect original module data hash on
>> READING_MODULE_COMPRESSED and defer appraising/measuring it until on
>> READING_MODULE when the module has been decompressed.
>
>This paragraph is a bit awkward.  Perhaps something like:
>
>-> so IMA can calculate the compressed kernel module data hash and defer
>measuring/appraising ...
>
>>
>> Before enabling in-kernel module decompression, a kernel module in
>> initramfs can still be loaded with ima_policy=secure_boot. So adjust the
>> kernel module rule in secure_boot policy to allow either an IMA
>> signature OR an appended signature i.e. to use
>> "appraise func=MODULE_CHECK appraise_type=imasig|modsig".
>>
>> Reported-by: Karel Srot <ksrot@redhat.com>
>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> Suggested-by: Paul Moore <paul@paul-moore.com>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Thanks, Coiby!
>
>The patch applies cleanly to linus' tree, but needs to be applied to next-
>integrity.  Please re-base.

I've sent v4 which has been rebased onto next tree with improved
wording as suggested.

>
>-- 
>
>thanks,
>
>Mimi
>

-- 
Best regards,
Coiby

