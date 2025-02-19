Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B292580C6
	for <linux-security-module@vger.kernel.org>; Wed, 19 Feb 2025 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001378; cv=none; b=D9PJA+nbWP/4jAmFJ6yxnm6wo3Yay+DIt/bRfr2FrhkRYCaA4QI0yBrnQVjvtosW2/T70Jr6Zh9hiDCgWXdCyOjrSPVofUhDw/SWTc8gl3u7eYFtvlNum4WKMecGMBcbuLWHrPDbnqCBstAkHeu84943PfsW8dj7zZiURl95l6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001378; c=relaxed/simple;
	bh=ktyqg6VXobNyUJyUjF636V9vxWs46tGUa7a+rwBx2Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F028oFP4bYADLCfi/Ebv4s0E9fedhDcsl8U9CaMMvXLf+enKae1LMeXB2kczK3qItM+bdUuSXEdInZt5YTqubwwR732jllmzoA48b8yR4NpAxGdYCpCCjvN1veXh78GjUuLbEw064xLpTQ+TqFH8y3cTBooKvNoxSoAZ/gTybms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gi0eqFel; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gi0eqFel"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740001375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U1k6JUYebl5L/ZIBngi7EsN3JLNc4iz6NkCHr2NsZmU=;
	b=gi0eqFelbBuxz/SdnYRR7IKfJh7uX16LjQDA128DigkKqexYOrj3T9hHpUfQDkchakmrDa
	S5NzsBf7BIP741XWczjwj0fvSO7wcOzvKasoc+lnFFL3Af8QOsOgcDJfZqsszTMjhhO+J1
	BlwHNYQhULeoiaEMH7MIvsQkRnUd1AM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-0AFJFrZ3NJul3J6p6D4m-w-1; Wed,
 19 Feb 2025 16:42:52 -0500
X-MC-Unique: 0AFJFrZ3NJul3J6p6D4m-w-1
X-Mimecast-MFC-AGG-ID: 0AFJFrZ3NJul3J6p6D4m-w_1740001371
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B05E180087F;
	Wed, 19 Feb 2025 21:42:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.102])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2F689180056F;
	Wed, 19 Feb 2025 21:42:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Feb 2025 22:42:22 +0100 (CET)
Date: Wed, 19 Feb 2025 22:42:18 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] yama: don't abuse rcu_read_lock/get_task_struct in
 yama_task_prctl()
Message-ID: <20250219214218.GF5948@redhat.com>
References: <20250219161417.GA20851@redhat.com>
 <202502191125.1A6F07E@keescook>
 <20250219201742.GD5948@redhat.com>
 <20250219210042.GE5948@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219210042.GE5948@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Damn, sorry for the spam ;)

On 02/19, Oleg Nesterov wrote:
>
> Forgot to say...
>
> with or without this patch the usage of ptrace_relation->tracer/tracee
> doesn't look right (safe) to me... but probably I missed something
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Yes I did. I didn't realize that put_task_struct(tracer/tracee) calls
security_task_free() -> yama_task_free().

Sorry fo the noise.

Oleg.

