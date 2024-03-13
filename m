Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05679C122
	for <linux-security-module@vger.kernel.org>; Wed, 13 Mar 2024 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710297620; cv=none; b=gN/iWJ8N2Kg2jyc0fNmyGzaUomS4CBG7CmMankYYR8WB6ZcLyKMJm9kYBPuO2B8JTs41kyvczdtU71wIJTDLK1DU8w9an8bhB+3QjaXLKMo40yDzEX39EtwUY8Lp6/wxrboPJOe6+63WhtJRMojeBTdnnlFZqHuGLeIThFr09fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710297620; c=relaxed/simple;
	bh=bT9cgD9xoMLhqt3/eDR3nr6SSI/CyX28YEwHte2GLxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kVV/Cq5bvy9BzsNulMQEuEMu6Pa2MeGVglOxYD9VGQEzX9FRcv9bmf20X7ZCNtIqFO4F189zGw4F+2g6pcC7sZnGQJL6Q+q/ITKj/cL419gtxFlwOUC9l/lfLg0mSZQfd293xtlfBkJG9PbpEaCuIp1zDFqnCFk98mGfWVIoSvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgQ0JuPg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgQ0JuPg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710297618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xLDKnplj27bk7XMdJMqwJSbyHYnIPFsAuwJfX8G+gAU=;
	b=KgQ0JuPgHoV0+clD26G82HuMpE4ngpdzpP0TjxxeA0awucPpCX+y1Zt2W0+a4Pk+yanpWX
	w/3kg40JJYYTmtXDzD5HkRluFZVH9Xm/ldjNB3pa4Eg3EA44qrxr+Q3TXYpmocDKiAqK/p
	Na//6sVb8nuTXjZDV09dDTfCg6w5xQs=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-7aRZKD_JMre3ald5tJOoHA-1; Tue, 12 Mar 2024 22:40:16 -0400
X-MC-Unique: 7aRZKD_JMre3ald5tJOoHA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-221a4d886fcso6102505fac.3
        for <linux-security-module@vger.kernel.org>; Tue, 12 Mar 2024 19:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710297615; x=1710902415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLDKnplj27bk7XMdJMqwJSbyHYnIPFsAuwJfX8G+gAU=;
        b=jDv+nNEcbyWlCMRE7Va4lyW9n03hwYPOajLkwNdveKspnzjI/gP/IhFajEJitjnt6l
         FdLTqBIH1KOf8AKh+oAQkCb+dsHCb0IEzngu19AooinYqjfgUarXM57hLobhkjF/hRMp
         6cuS6y4U2lUsahAh3XieaLA1h3JiV8/zJl1e8uV4xTrV70kMXOiMFOoqV76gPZpuKPFc
         aGwJtEp6TAqSFennY/HhUS7FHuC8eBfNZpr2uK+JP9VWeAbPtLmqONPqGN8qxC4aakb+
         e0BXBH+EFVZl2vpNhKqIn1C4W7Pg8m6yeMtNKRjMNXI5yyGC3HL9yK6XKe3PYhBhvQJe
         +pew==
X-Forwarded-Encrypted: i=1; AJvYcCXz6sYs+YQ3CEup8s+BEuAxs+3aOeaUV6xMbve7zpeMWuOLS5Fyd6uGGJ946roWA5FhAqReimXIoY/18DzFyCPp5+IeepMxrf1IRhTFdUEA1FHhVL2M
X-Gm-Message-State: AOJu0YwwtzUtPimQlOY10LEcv+txZLznBTWb2yjJC6NeH3LdN+8niA3F
	DVvFW7LAZ9ECuX+oZwckT2i8j1Fe1vtFJM/8lOlFNN3jIDZSxP08wtZ/sNYk9xzq12ByB8TEtDo
	Skeju67tEygZC+89Wf1WDgD+5XLXXhp9cpWsQgXFHi8tisVGQy1Oa7GXu82bhjw/cnzP8KxcNZw
	==
X-Received: by 2002:a05:6358:3401:b0:17b:f4a1:b626 with SMTP id h1-20020a056358340100b0017bf4a1b626mr14909057rwd.13.1710297615395;
        Tue, 12 Mar 2024 19:40:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2czkJxHHK8iTWoJP2+GXQgOSzrR8EUnlqBRIqzbEfeFRiTVhU4BFfN2MY00qNUPEEuj0R+A==
X-Received: by 2002:a05:6358:3401:b0:17b:f4a1:b626 with SMTP id h1-20020a056358340100b0017bf4a1b626mr14909016rwd.13.1710297614481;
        Tue, 12 Mar 2024 19:40:14 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d12-20020a63d64c000000b005dcaa45d87esm5975622pgj.42.2024.03.12.19.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 19:40:14 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:37:29 +0800
From: Coiby Xu <coxu@redhat.com>
To: Maxime Ripard <mripard@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-integrity@vger.kernel.org, itrymybest80@protonmail.com, 
	Eric Snowberg <eric.snowberg@oracle.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] integrity: eliminate unnecessary "Problem loading
 X.509 certificate" msg
Message-ID: <gucfr7sxmv4hiowr6dokx7r7nf6wdiqdm577arnwe5yua5z24b@3sljt73mpjke>
References: <20231227044156.166009-1-coxu@redhat.com>
 <20240109002429.1129950-1-coxu@redhat.com>
 <20240306-humongous-nuthatch-of-science-00e58b@houat>
 <a677a9cd8eda40e5529094ba2a6ad2f7c0c927fa.camel@linux.ibm.com>
 <20240306-large-lush-catfish-e75cb2@houat>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240306-large-lush-catfish-e75cb2@houat>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Mar 06, 2024 at 01:40:01PM +0100, Maxime Ripard wrote:
>On Wed, Mar 06, 2024 at 06:55:00AM -0500, Mimi Zohar wrote:
>> On Wed, 2024-03-06 at 11:57 +0100, Maxime Ripard wrote:
>> > Hi Dmitry, Eric, James, Mimi, Paul, Serge,
>> >
>> > On Tue, Jan 09, 2024 at 08:24:28AM +0800, Coiby Xu wrote:
>> > > Currently when the kernel fails to add a cert to the .machine keyring,
>> > > it will throw an error immediately in the function integrity_add_key.
>> > >
>> > > Since the kernel will try adding to the .platform keyring next or throw
>> > > an error (in the caller of integrity_add_key i.e. add_to_machine_keyring),
>> > > so there is no need to throw an error immediately in integrity_add_key.
>> > >
>> > > Reported-by: itrymybest80@protonmail.com
>> > > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2239331
>> > > Fixes: d19967764ba8 ("integrity: Introduce a Linux keyring called machine")
>> > > Reviewed-by: Eric Snowberg <eric.snowberg@oracle.com>
>> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
>> >
>> > Any chance this patch can be merged? This is breaking (at least) Fedora
>> > at the moment.
>>
>> https://git.kernel.org/torvalds/c/29cd507cbec282e13dcf8f38072a100af96b2bb7
>
>Oh, awesome, we missed it.

Oh, I missed the emails about Mimi's PR sent to Linus as well. Btw, I'm
curious to ask why you used the word "breaking" because I thought these KERN_ERR
errors shouldn't cause any real problem.

-- 
Best regards,
Coiby

