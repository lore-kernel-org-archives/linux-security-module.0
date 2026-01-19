Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39613FEF
	for <linux-security-module@vger.kernel.org>; Mon, 19 Jan 2026 04:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768796159; cv=none; b=PBRJAIcAgcaQIsC6pqcDxPFglg1bqP0hxT4Q3af4MXeTDgsn5EYXxUItDUcY9j5SMG/v6Zfvl/tYCM6kLxVexDCsJuyUBhNppsHlHw4NNT+Pifu1qeYpSAFbEFX/J1G1Pizq3ucJrJV4COjCOqXAAyLl3nuWcA1q84lJCla8+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768796159; c=relaxed/simple;
	bh=Q4XorKD5YS6S0fB5vVv5DXfr9ymxSk1r7VwLAiX3vw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sN8a9QKYaggQy6SH3dzr5AQiZVB3hPzYOxEoitcGmzmsgffnfukN3yz2toef7NFR2k0XvDWuHgbZwbZSNbkJNes8ATGac3w4dhA2hvsAc168vUxBPh8QmOHNIyu2qXL5Dypd6bDVO77eE+UwM9pRFUbBbMFYZ0xQy94Y9qhzYS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2WqBeF0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2WqBeF0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768796156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XmVPCf9pEYrflYW5gEcXAfiX8WqXl7WYVPdJt2MNiMA=;
	b=h2WqBeF0lyKKJNP+XxkpEdGCLRPqKzfzXeyg/590ZGG0R7Z4k9iEgXH2PRkyOqv4ghdnSn
	iJ8L/0V50pwjezmtzdMvxAULEGPphp8J25WU8FQaVl6JNi1JEgWePHmsb/bTziCpR2Uia4
	MAeeHO2E6T+cgHzRi/EKuA9/ThUjzNU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-ZlF4b_rcOcW6tQS7vxzOqg-1; Sun, 18 Jan 2026 23:15:55 -0500
X-MC-Unique: ZlF4b_rcOcW6tQS7vxzOqg-1
X-Mimecast-MFC-AGG-ID: ZlF4b_rcOcW6tQS7vxzOqg_1768796155
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c549aaa796dso6421673a12.1
        for <linux-security-module@vger.kernel.org>; Sun, 18 Jan 2026 20:15:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768796154; x=1769400954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmVPCf9pEYrflYW5gEcXAfiX8WqXl7WYVPdJt2MNiMA=;
        b=C0ADEJNho5LELnPYzTTojxH/oo2ZJLdZJdED/0/p3UMJVHK0gAFvAChOcyxZdKqZmv
         JUqUW+tbtfr8P5LNaVGK/CVWud84bmyC69NLK9vJVbQ8xm3wR3Kx629R9vuU+GGqjp1Q
         6D/dNi2HEuJ+lrp+qbDnLqfD/ZOWWGSETt86lITWc07l5FS92zkgM1XCMvOLTn+sMqb+
         4SVdALVXyGvKKj6T6acG0aOp4MG2TJ+j/SjAw5DUVhqpUlLFeeT9xGxd83T2rN4ngAgC
         kswZiGsjP1ZdfsbturAwgxTtHemnxGgz1THp0JrRrSM42wzEBpzKtE2gyNeuKnwKWOIw
         U4cg==
X-Forwarded-Encrypted: i=1; AJvYcCUS2/Hie0S8mKs9gMhgnDttXq4OT1Eq10mo9egAW5of7ldCGX8wU7rLThRqgeXWVOUKXwostLzUegiB4qU1FLux0uPa2gE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl/IOFOMjCFWM/VTBDCgAqk66Mnxpmf7DRIwnuCY/u6P4137QZ
	cL0AHPWbklGSY+sZvDQ3pf9d2LrNPO9dssMyBJS19Ixouqhv8iixRIhk5M9Guq9Y98Rz4X9G0aP
	hdIgHbkPEE+kgFHjZXMJeXde4NZc51dRlIrEUrneEU0OjH3VF0BShVgVH62G+rFY731K1ZWR75d
	szSA==
X-Gm-Gg: AY/fxX7HLcUQIonFMTs8H5e1vP1fhkujm/7KTng7KIK7/JoKsGpybeHjiMtsJF1IJXB
	78NZ4FXMcCzdpjpoASnl8nXQqbylvk0gn98AiXp6Ljn0/ClWK4Tj5kTgfW4p8hlx5waG+1WpdZX
	zZQGaM2zhS1zBQxUmhG6R8KJnC7et9L3H5LVI8uIu2wdnh277ToOap58HlFoW/1HVfXT9nQfl5/
	zfIY3eeuo6XbHP2h/GkkKeZljbCE/gByzPy0TeBhJOsNtozHKCC+g7NyEtnPP7AZ0r+YuRDS73p
	T8cp6Dqp24luWRWaisWawWD0bKMblyhZsugLtTUDP9FJjfdbyxE0+bj1iAv8OP3hYYYwjdPvSde
	J
X-Received: by 2002:a05:6a21:7103:b0:38d:f226:49fe with SMTP id adf61e73a8af0-38dfe7c307amr9251481637.63.1768796154613;
        Sun, 18 Jan 2026 20:15:54 -0800 (PST)
X-Received: by 2002:a05:6a21:7103:b0:38d:f226:49fe with SMTP id adf61e73a8af0-38dfe7c307amr9251469637.63.1768796154115;
        Sun, 18 Jan 2026 20:15:54 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf32d2a3sm5939653a12.20.2026.01.18.20.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 20:15:53 -0800 (PST)
Date: Mon, 19 Jan 2026 12:10:54 +0800
From: Coiby Xu <coxu@redhat.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	Heiko Carstens <hca@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] evm: Don't enable fix mode when secure boot is
 enabled
Message-ID: <aW2uAwtNdq3KhsFa@Rk>
References: <20260115004328.194142-1-coxu@redhat.com>
 <20260115004328.194142-3-coxu@redhat.com>
 <522f60ac43b8757c0d7df5df0239190e49f577a8.camel@linux.ibm.com>
 <f38b2512d51351f83c51b6e2b5dec11eb7e6959d.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f38b2512d51351f83c51b6e2b5dec11eb7e6959d.camel@huaweicloud.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qbv-4el7fKo0rwXrHs4NcjsMFGSVLSxUWzNz-SZv3Uk_1768796155
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jan 16, 2026 at 01:06:32PM +0100, Roberto Sassu wrote:
>On Thu, 2026-01-15 at 13:15 -0500, Mimi Zohar wrote:
>> On Thu, 2026-01-15 at 08:43 +0800, Coiby Xu wrote:
>> > Similar to IMA fix mode, forbid EVM fix mode when secure boot is
>> > enabled.
>> >
>> > Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>> > Suggested-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
>
>Ah, if possible, could you please change the email to
>roberto.sassu@huawei.com?

Thanks for the reminder! I'll use the above email.

-- 
Best regards,
Coiby

