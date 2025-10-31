Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959FB2F49F5
	for <linux-security-module@vger.kernel.org>; Fri, 31 Oct 2025 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897620; cv=none; b=ubLVSmo+eCc34XuDjvOnRn0Af7jbNkmhLS5b2WTKsex6SvMz1gIaL3yrEzCPxLLcRuCExsAVqmR36Gcpk01y6XlkWipznINZaVpx+IRIKHUsDB3ptWEqeZHnLXUyse3cKZJHu8/qrkp/Tb4b5IZQgTPaOFdZjCssGQpufSPxZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897620; c=relaxed/simple;
	bh=lB66Wru9u8c0qnRy/70ZKohUPZs+4FPyI3uKveKSmO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DRb+iUdRE0ATt1EyhAIgGcEuboDakpR+m1j7FBQaruWDg4mQDNecIItnbucUq0gfekzD42Vqg5qHzlWkdXJ0mCTwRl9NBX3KLq4U62Q2BzQvJWGLPls6zjuZXmwryAG85wJUmXXXA9oGxhd2mD6RjmH1C2txbS5XiFCFqohmXtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HGA80Tet; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGA80Tet"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761897617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Py1md6slarrM8D1qGHaVb4pyrrj+/8Hoqbx6eKekEk=;
	b=HGA80Teto6e27vCj1SjOi+n8g9EEJSQDHsa2JaHrHkxuhNcQg1J4WOh6HhpmBli5wUFMAI
	sdXlnCzRWV4Jnaoj+cSaptENzOlcJdb6gIkK5CYWo2/wmxYQWjpHbkz7BO0umXbUmtEHc8
	fZ0wfnCHA8FJqBLP6zTodWhGU2QEJUI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-nHU7krsQNCiyUNto-Zm1NA-1; Fri, 31 Oct 2025 04:00:16 -0400
X-MC-Unique: nHU7krsQNCiyUNto-Zm1NA-1
X-Mimecast-MFC-AGG-ID: nHU7krsQNCiyUNto-Zm1NA_1761897615
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78117fbda6eso1766313b3a.3
        for <linux-security-module@vger.kernel.org>; Fri, 31 Oct 2025 01:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761897615; x=1762502415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Py1md6slarrM8D1qGHaVb4pyrrj+/8Hoqbx6eKekEk=;
        b=XctlIBEEdscgAIoUR8e8JcnLLhWWfE/SDBVXGDk/aLkpfkHdy9BM/tyUft7qYS8xaV
         07SGSknhprZxiWLzuWkrU5S9ez0/Xl/s4cAxsIzBfsuewbY+R/0FwN3tOsznkR+UGdOY
         p3MrjkGH1iM/mnz0Xu+QGP9fXn1FSZKweuM7eTU0bi1qQJXlFyKdKAmoRaxniRuDhjiO
         QdqeE9ybxR8vR2VGawJyWWHN2VdPfI3qYDH43VQi4YPsjUR+BRBKMf/rtRElv9Ybds9h
         dJpIejxNtAQTrTSKbKpGjRfNPpyC+n37hWXWylU/nKT54rV0TXiSOTnwKKJNRoNH2ihR
         w0ag==
X-Forwarded-Encrypted: i=1; AJvYcCUnRUxOPB352s0auwB7Trad2wil6MTzooyLDoFspSrwwDpJnh4d6bHqQyt9At0NlOCxtjWebEEYaliaZ95e60mq3M7JR10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd01pz5nHhCIZN/SK0XN/GcO7kDM3YQAt5V+UpdOcXA9arRgqn
	j2GtNxg1c8gABiDD2S4uUQ+tCF2FxnpoZY9QkLukZhdDvItgMzV4zdHkFnYruOdJmdLu5tXVaDd
	yIofEgLe+C9RHYY3ouOJcnWXLEaVyirJIrrK41EyvLcdvLZHOvKo2x6DZ7JOU/YIZQNuky/J8Rc
	776g==
X-Gm-Gg: ASbGncs87T6oEVv0yvO3IUTpj3rV6xpDgurEj9u0M5aaCK9rIoQ2M6vM0bEM8Y1Blfk
	V0aeNlY3w2Fiy6q4AdNdU+fPc1rEIxBwGGB2Yn6q6noLiZed+Wje1bLo4Fh2TnTDf3Ae/DujQBx
	5tDRrcIURnFZDATt3juKt8AjUx4cFVmyCp7hH8JDeh5bmDKhroIi+FmW239dNspxXVFUeB2XNdH
	idnng3QDA/fj8Ove0NqxHVQtGF6IifP8dDZ9Cjr96/bmSW1R9wB7jFi3WrFKStcr5N+pv9F3Ffr
	zyjDU+OkkEcSs8XNq86xo976TnYBd13HLW7ATIfWnlOmRupDMchrbrpeNgGSm99Pqg==
X-Received: by 2002:a05:6a00:2e9c:b0:781:16de:cc15 with SMTP id d2e1a72fcca58-7a778cf3a96mr3521398b3a.15.1761897614750;
        Fri, 31 Oct 2025 01:00:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDLa7KGTb5wSf4W252Q0VnFRq/HtpgYqzeaYMwjIvkHvSdOsEAOc6ZNfr8cT8FHHmEHw3VRg==
X-Received: by 2002:a05:6a00:2e9c:b0:781:16de:cc15 with SMTP id d2e1a72fcca58-7a778cf3a96mr3521347b3a.15.1761897614194;
        Fri, 31 Oct 2025 01:00:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8982117sm1250591b3a.15.2025.10.31.01.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:00:13 -0700 (PDT)
Date: Fri, 31 Oct 2025 15:58:11 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Karel Srot <ksrot@redhat.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: Fall back to default kernel module signature
 verification
Message-ID: <wlc2cylowxiuvfvj2yizes364yr27i3um5xen7ilyd4t2i3xzx@uucsqesigr2l>
References: <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
 <5bzredottmp2tdm3uebzjfqjr6c7bwssqkrbdqvudruvzr764e@37j6ycjci2sk>
 <27bb0c218084f51eba07f041d0fffea8971865b9.camel@linux.ibm.com>
 <z6f4getlayaxaxvlxfxn2yvn5dvhrct64wke4uu2s3dfll3bqq@754bklrku55n>
 <559f6ebf4a19da321fffc2a3ca180dc3d6216a22.camel@linux.ibm.com>
 <02d18fe0a0ca1223eec9af5c8e01739aa164bf32.camel@linux.ibm.com>
 <xldwpvz4gzp74kualadf2n2wdlpbo3xorrgvkibhdocjtroipd@dpukmalev4yu>
 <26cb0926bd707edea6f19ca1bf8f5d5d3d10ff96.camel@linux.ibm.com>
 <pbkvp4o4m3spjgvctapidfnsswakekxl2vyigqip6yyfzp73z4@rgbohq7h4nnt>
 <1fb245a0e72a360df3a768726351e7fa76301471.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1fb245a0e72a360df3a768726351e7fa76301471.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yXQMol14hMRSNBzy8lvOICIgrzJ8sD2oZP8TUrZRN6I_1761897615
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Oct 30, 2025 at 12:50:48PM -0400, Mimi Zohar wrote:
>On Thu, 2025-10-30 at 21:42 +0800, Coiby Xu wrote:
>> > >
>> > > Another question is whether we should allow loading a kernel module with
>> > > appended signature but misses IMA signature. Both IMA arch specific policy
>> > > and init_module syscall only require appended signature verification. On
>> > > the other hand, we only allow "appraise_type=imasig|modsig" but not
>> > > appraise_type=modsig. How about we allow loading a kernel module with
>> > > valid appended signature regardless of its IMA signature? We won't call
>> > > set_module_sig_enforced but as long as we know is_module_sig_enforced()
>> > > is true, we allow the module in IMA.
>> >
>> > Based on the policy, IMA enforces signature verification. Only if
>> > CONFIG_MODULE_SIG is configured, the IMA arch specific policy does not define an
>> > IMA kernel module appraise rule. However, custom policies could still require
>> > both types of signatures, not necessarily signed by the same entity.
>> >
>> > The option "appraise_type=imasig|modsig" allows either an IMA signature OR an
>> > appended signature.
>>
>> Thanks for the clarification! If I understand you correctly, some users
>> may want to enforce IMA signature verification and we should provide
>> such flexibility. Then do you think it's a good idea to change the kernel
>> module rule in ima_policy=secure_boot to
>> "appraise func=MODULE_CHECK appraise_type=imasig|modsig" so
>> ima_policy=secure_boot can also work for in-kernel decompressing
>> modules?
>
>Yes, that's fine.  Unlike the arch specific policy rules and the Kconfig
>appraise rules, which persist after loading a custom policy, the builtin secure
>boot rules do not persist.

Thanks for the confirmation! v2 has been posted.

>
>Mimi
>
>

-- 
Best regards,
Coiby

