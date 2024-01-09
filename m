Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0D2623
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jan 2024 00:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idPMmWv1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704760517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ARMX4HM6itdBlTBKVKSEXcT1ilseNu4Nvq2nBbOEvW8=;
	b=idPMmWv1G8IGqQWWzamTsyMvZ+QWDnK8b8NBo+5J9XfPGLwR2cMyyHjrp+k/622NmmDuMC
	EhEUxjjS9BrR7f/MlWojavoyPlt6zZZu6cheWYnhIZClBiwnYcHPAUI/6W+kuZoXDOBsi7
	3itL9RHsU5eEpy58xq+AbYeYug8Exug=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-2b4Bs73ROMycdmsEecAXHA-1; Mon, 08 Jan 2024 19:35:16 -0500
X-MC-Unique: 2b4Bs73ROMycdmsEecAXHA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c670f70a37so1958557a12.2
        for <linux-security-module@vger.kernel.org>; Mon, 08 Jan 2024 16:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704760515; x=1705365315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARMX4HM6itdBlTBKVKSEXcT1ilseNu4Nvq2nBbOEvW8=;
        b=WsAXqQ0aozIG4Hn/PsuB/qhFDcXLtgDTWRPSZkzkej6vazPsL8VKaJnjYhhlsbFx1t
         2l5GycVK3QW9SRNxLHKlmMJiBrhyBbp4ItcM1wzzBmGc/rBJ4N9Vvyd7qe/o7jBbWePj
         UuOevrbglDjZZ3s2F4OCJKgD3WfOgPUH+Rdh8BdYjuxjD7DyX6qT2R+YWq5ebPwS5def
         TRYPDa28/I/mVlveEcfc6GAwib+NlqBmZeEoMi05uQ0tu2DDMGztk1g9M0gZx4EQtfNX
         5NyyGJxMaYjUPudTcc6Fu6nt4xVSXBxM3I51vaT5i4oGduBPIPQEm+5oijlWupkhfGO3
         vRrA==
X-Gm-Message-State: AOJu0Ywgt1P1EY/ZfVHBm8G5CKhrDKk/n1eDxGyfUjbZqybxMYvlkzwn
	DmPX9i68RRBBJ8TqWE/wamc5UHIZ7/5yC5n9l7Q2Gw8ZqJGfOSpPcNBtO2chh1sIusU4BZ/oI1I
	6/tgFnBA4lf8DWMirdEZqrAwFOivoRF6phfRaDfdX3vrK
X-Received: by 2002:a05:6a20:65d:b0:199:f2ef:8282 with SMTP id 29-20020a056a20065d00b00199f2ef8282mr122305pzm.100.1704760515686;
        Mon, 08 Jan 2024 16:35:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpvMu4Ls9SGUYo6jmphzFnSHZMJQHYOZu5gp20jJVmFV8u2Z+IYHNt7UlyuoeL2/n3onexSQ==
X-Received: by 2002:a05:6a20:65d:b0:199:f2ef:8282 with SMTP id 29-20020a056a20065d00b00199f2ef8282mr122295pzm.100.1704760515363;
        Mon, 08 Jan 2024 16:35:15 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b15-20020a17090a12cf00b0028c89122f8asm553134pjg.6.2024.01.08.16.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 16:35:15 -0800 (PST)
Date: Tue, 9 Jan 2024 08:30:03 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, itrymybest80@protonmail.com, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: [PATCH] integrity: don't throw an error immediately when
 failed to add a cert to the .machine keyring
Message-ID: <vzys7y22d7zduhcrlqojnavcad5zvxde4axdsgrfpwn3u557iz@cnjbuwkfqiur>
References: <20231227044156.166009-1-coxu@redhat.com>
 <39e5612eb2d4dea2759310ccce39c1ad40b5388f.camel@linux.ibm.com>
 <35tiggwgbrb2sapyykv3umio5l2xqhmzc43wy33dxmz4hyu24c@bprgz7skpxma>
 <16ae3e51dc4eeb2b2e674b8ff1051ac315fa492c.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <16ae3e51dc4eeb2b2e674b8ff1051ac315fa492c.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Jan 05, 2024 at 09:59:14AM -0500, Mimi Zohar wrote:
>On Fri, 2024-01-05 at 21:27 +0800, Coiby Xu wrote:
>> On Tue, Jan 02, 2024 at 12:54:02PM -0500, Mimi Zohar wrote:
>> >Hi Coiby,
>>
>> Hi Mimi,
>>
>> >
>> >According to https://docs.kernel.org/process/submitting-patches.html,the
>> summary line should be no more than  70 - 75 characters.
>>
>> Thanks for pointing me to this limit! How about
>> integrity: eliminate harmless error "Problem loading X.509 certificate -126"
>
>Still >75.   How about the following?
>
>integrity: eliminate unnecessary "Problem loading X.509 certificate" msg

Thanks, v2 now uses the above subject. I thought the limit applies to
the "summary phrase" instead of the whole "summary" and a second look
proved me wrong. 

-- 
Best regards,
Coiby

