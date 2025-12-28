Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73C910F2
	for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766939886; cv=none; b=aSEMWsxoFBB781iCMkbSTwCNb7o3CgKKAYEIiY8jt1NchqyVFNrgLsB7eNNcxEsm2hsqX+ok+MPF6ZRV+bOdJQ19ps8jqXMV+5KLOkxEt2NuSDMl8ubSrLEST/2VplpDo032JC135SKGHNr9LC+0kVdz5To0hFpKzR7a2KOiNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766939886; c=relaxed/simple;
	bh=A1CloLTF5mtKQuQfJ6+s7+liPfl3Njzrx3VljXnL8No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mP/i8nOv3g8Cd5Ka4fPBlO2Z8vBmB+i2clG958eMAKiEYDmvVWZaPHDYmvcM/l4rWB/heFfnGJTZ6b1QUV4dfEL0VtsMH7QigqnpjMld0uuMfvT/8AoJLGBi1t8Q05kAfHvTkjnQ/PqH96zA9S77T3YSjuFMBoX/J1GgDaZAQqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je/RITCe; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je/RITCe"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-787da30c53dso79956857b3.0
        for <linux-security-module@vger.kernel.org>; Sun, 28 Dec 2025 08:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766939884; x=1767544684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tygNOXrVXAO4ZHpUhB7BjUuKJ9KU2ktEMqQxx64GBSg=;
        b=Je/RITCePWoLmTqF3vSRgJMTpmkAAk7kZ35VxDOMgCEFCjonJbIKN1UoakEEqziE9K
         4r0KIxccQA+7XG5qZJBaP22UY55RS2NaHSm3YylURPuOdrio0iU6VQz7qSEzPG/NC7Cl
         Au5UvDcaa7dGBELZEpOQ+8qX/ms30p375SZuG+yrAh7Xj40A15d626Z2djxZwy/Y4M8v
         3y6ceprzrmGAbRSMweZDhpMxinsA9BCHEj41cOaCnYrhIsrUCz5uD86QCnZXr+CySr0+
         RwMxzdfl7tIAgE2hyFJ8mKutZSvkxMoHT2GQ4b8tnc8Hlfa3MYnl34+XSGWKeuDfBRlT
         KCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766939884; x=1767544684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tygNOXrVXAO4ZHpUhB7BjUuKJ9KU2ktEMqQxx64GBSg=;
        b=Yg3dHI8ZguJUAm4CvLa0DZmcZ1M4RbxCImszT29ULpIy2oa2oeShG+99WG9K+3ZkeU
         AYp5TREMf+07DijjQ7bOEEKCtCo1UOYCOjOPiDELxp27ZXeiFdP/JYfTIVSsrIVOgdlP
         Xq/65qduqSb7auIPfZPYQeA3vfQ0rsNpRbQRuXJbmERT+g1IPXl+fWo3UEuA2b/2wkSu
         6Vph1+FhHMSLjNn6oYtvFbS17KCnzFaGxpmOg5i2ATmScgGz+8PZMk4qX0X8gv63/V0h
         69lrpTBCHw4NcXPBHqSObaRHoZFaZx2JOGoFguyCTVbvxrfY9QKCwqL5C4GpVwwImoP8
         NayQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx5/oNZkU2B2795p7Tr4m+83HS+AWgZJ0ANwBwQxZu28G0xtHWNrpa4EJTjGec77g5+ToGpVd/r+YvnEj25OBkS4vbrBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ87c1jy9xi3ktgcpxTAfcgGjSHcWDnq4yxZbBvAsigJ7vQcDt
	vu0g6TBRYc2BMYn9hJxmMObIBXnuFcCFfOc9ygVxBwHdDe6IoRsTRY1H
X-Gm-Gg: AY/fxX7+wyXjy0gX31+OvD9FCD7OjvHLlTSE4snRxi1+zTTv7RLrgfsH+b54rkIXK6b
	eFnc5u8tWPDYZW7LwZ85QOnw0hmv3AcpPQzY5abxaxPDmGpHzn947j0lH90ZbVZtWJdZgUffBeu
	oQauVGHvuzg0qLmilQR4ENSgauLfaDoPxLRcNgjbWIuXQtQUywPR2UnvvVlwQtM7k5uk5mvHPFa
	jDMWgJ71yZc0w9Nz+WGd2TMioedhmJuE+oB9UrDh2rivf0w95favyJX2QO3DPgQk8BOe9/PR6A9
	E58GuANGad1HmuFyKRof1EgyKQGj9H+hf4/ywBr1oEOlzOHCrKOUV/+Qwqv0yq1WWZgfAIQfQkR
	SZRcsM/iXBgalwu1U4K4neyJ6waDo56jW8lMsBHIXXkzfmos2UFqgD9HJXDD7ULEH3BN8ZGxXRF
	V62gAkwHFwBhjGswHZkW6Bg7hFflxBFjEBICEUrUkl4u9NLRmJzOw47RMZCfpa
X-Google-Smtp-Source: AGHT+IGTomDvweFk1OHsvcvF/D7IGaQA86P09HxPeunGeGLQwbjjmWyfABeI7BpA1AFp+r7utL8jpQ==
X-Received: by 2002:a05:690c:6088:b0:78f:8b7b:790a with SMTP id 00721157ae682-78fb404507amr228393857b3.15.1766939883569;
        Sun, 28 Dec 2025 08:38:03 -0800 (PST)
Received: from zenbox (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43b298asm105999777b3.19.2025.12.28.08.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 08:38:03 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: m@maowtm.org
Cc: demiobenour@gmail.com,
	fahimitahera@gmail.com,
	gnoack@google.com,
	hi@alyssa.is,
	jannh@google.com,
	linux-security-module@vger.kernel.org,
	mic@digikod.net
Subject: Re: [PATCH 2/6] landlock: Implement LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET
Date: Sun, 28 Dec 2025 11:37:50 -0500
Message-ID: <20251228163750.451028-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <be315d8ff7544fd91bdb922e8afc7c8154e3594d.1766925301.git.m@maowtm.org>
References: <be315d8ff7544fd91bdb922e8afc7c8154e3594d.1766925301.git.m@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 12/28/25 07:45, Tingmao Wang wrote:
> Extend the existing abstract UNIX socket scoping to pathname sockets as
> well.  Basically all of the logic is reused between the two types, just
> that pathname sockets scoping are controlled by another bit, and has its
> own audit request type (since the current one is named
> "abstract_unix_socket").
>
>
> Closes: https://github.com/landlock-lsm/linux/issues/51
> Signed-off-by: Tingmao Wang <m@maowtm.org>
> ---
>
> There is an argument that there should only really be one audit request
> type for both sockets, since the only difference is whether path= is
> followed by a normal path, or by a hex string starting with 00.  But I'm
> not sure if we can change this at this point, so I have created a new
> request type.
>
>  security/landlock/audit.c |  4 +++
>  security/landlock/audit.h |  1 +
>  security/landlock/task.c  | 74 ++++++++++++++++++++++++++++++---------
>  3 files changed, 62 insertions(+), 17 deletions(-)
>
> diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> index e899995f1fd5..0626cc553ab0 100644
> --- a/security/landlock/audit.c
> +++ b/security/landlock/audit.c
> @@ -75,6 +75,10 @@ get_blocker(const enum landlock_request_type type,
>  		WARN_ON_ONCE(access_bit != -1);
>  		return "scope.abstract_unix_socket";
>  
> +	case LANDLOCK_REQUEST_SCOPE_PATHNAME_UNIX_SOCKET:
> +		WARN_ON_ONCE(access_bit != -1);
> +		return "scope.pathname_unix_socket";
> +
>  	case LANDLOCK_REQUEST_SCOPE_SIGNAL:
>  		WARN_ON_ONCE(access_bit != -1);
>  		return "scope.signal";
> diff --git a/security/landlock/audit.h b/security/landlock/audit.h
> index 92428b7fc4d8..1c9ce8588102 100644
> --- a/security/landlock/audit.h
> +++ b/security/landlock/audit.h
> @@ -21,6 +21,7 @@ enum landlock_request_type {
>  	LANDLOCK_REQUEST_NET_ACCESS,
>  	LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
>  	LANDLOCK_REQUEST_SCOPE_SIGNAL,
> +	LANDLOCK_REQUEST_SCOPE_PATHNAME_UNIX_SOCKET,
>  };
>  
>  /*
> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 6dfcc1860d6e..9fbb0ada440b 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -233,57 +233,84 @@ static bool domain_is_scoped(const struct landlock_ruleset *const client,
>  	return false;
>  }
>  
> +/**
> + * sock_is_scoped - Check if socket connect or send should be restricted
> + *    based on scope controls.
> + *
> + * @other: The server socket.
> + * @domain: The client domain.
> + * @scope: The relevant scope bit to check (i.e. pathname or abstract).
> + *
> + * Returns: True if connect should be restricted, false otherwise.
> + */
>  static bool sock_is_scoped(struct sock *const other,
> -			   const struct landlock_ruleset *const domain)
> +			   const struct landlock_ruleset *const domain,
> +			   access_mask_t scope)
>  {
>  	const struct landlock_ruleset *dom_other;
>  
>  	/* The credentials will not change. */
>  	lockdep_assert_held(&unix_sk(other)->lock);
>  	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
> -	return domain_is_scoped(domain, dom_other,
> -				LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);
> +	return domain_is_scoped(domain, dom_other, scope);
>  }
>  
> -static bool is_abstract_socket(struct sock *const sock)
> +static bool sock_addr_is_abstract(const struct unix_address *const addr)

Nit: From the name sock_addr_is_abstract, it's unclear without reading
the parameter that this function only works with unix sockets, when
socket is an overloaded term that can refer to other kinds of sockets
(e.g tcp/udp/raw).

Maybe is_unix_sock_addr_abstract? or unix_sock_addr_is_abstract?

>
>  {
> -	struct unix_address *addr = unix_sk(sock)->addr;
> -
> -	if (!addr)
> -		return false;
> -
> -	if (addr->len >= offsetof(struct sockaddr_un, sun_path) + 1 &&
> +	if (addr && addr->len >= offsetof(struct sockaddr_un, sun_path) + 1 &&
>  	    addr->name->sun_path[0] == '\0')
>  		return true;
>  
>  	return false;
>  }
>  
> +/* Allow us to quickly test if the current domain scopes any form of socket */
>  static const struct access_masks unix_scope = {
> -	.scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
> +	.scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
> +		 LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET,
>  };
>  
> +/*
> + * UNIX sockets can have three types of addresses: pathname (a filesystem path),
> + * unnamed (not bound to an address), and abstract (sun_path[0] is '\0').
> + * Unnamed sockets include those created with socketpair() and unbound sockets.
> + * We do not restrict unnamed sockets since they have no address to identify.
> + */
>  static int hook_unix_stream_connect(struct sock *const sock,
>  				    struct sock *const other,
>  				    struct sock *const newsk)
>  {
>  	size_t handle_layer;
> +	access_mask_t scope;
> +	enum landlock_request_type request_type;
>  	const struct landlock_cred_security *const subject =
>  		landlock_get_applicable_subject(current_cred(), unix_scope,
>  						&handle_layer);
> +	const struct unix_address *addr;
>  
>  	/* Quick return for non-landlocked tasks. */
>  	if (!subject)
>  		return 0;
>  
> -	if (!is_abstract_socket(other))
> +	addr = unix_sk(other)->addr;
> +	/* Unnamed sockets are not restricted. */
> +	if (!addr)
>  		return 0;
>  
> -	if (!sock_is_scoped(other, subject->domain))
> +	if (sock_addr_is_abstract(addr)) {
> +		scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
> +		request_type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET;
> +	} else {
> +		/* Pathname socket. */
> +		scope = LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
> +		request_type = LANDLOCK_REQUEST_SCOPE_PATHNAME_UNIX_SOCKET;
> +	}
> +
> +	if (!sock_is_scoped(other, subject->domain, scope))
>  		return 0;
>  
>  	landlock_log_denial(subject, &(struct landlock_request) {
> -		.type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
> +		.type = request_type,
>  		.audit = {
>  			.type = LSM_AUDIT_DATA_NET,
>  			.u.net = &(struct lsm_network_audit) {
> @@ -299,9 +326,12 @@ static int hook_unix_may_send(struct socket *const sock,
>  			      struct socket *const other)
>  {
>  	size_t handle_layer;
> +	access_mask_t scope;
> +	enum landlock_request_type request_type;
>  	const struct landlock_cred_security *const subject =
>  		landlock_get_applicable_subject(current_cred(), unix_scope,
>  						&handle_layer);
> +	const struct unix_address *addr;
>  
>  	if (!subject)
>  		return 0;
> @@ -313,14 +343,24 @@ static int hook_unix_may_send(struct socket *const sock,
>  	if (unix_peer(sock->sk) == other->sk)
>  		return 0;
>  
> -	if (!is_abstract_socket(other->sk))
> +	addr = unix_sk(other->sk)->addr;
> +	/* Unnamed sockets are not restricted. */
> +	if (!addr)
>  		return 0;
>  
> -	if (!sock_is_scoped(other->sk, subject->domain))
> +	if (sock_addr_is_abstract(addr)) {
> +		scope = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET;
> +		request_type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET;
> +	} else {
> +		scope = LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET;
> +		request_type = LANDLOCK_REQUEST_SCOPE_PATHNAME_UNIX_SOCKET;
> +	}
> +
> +	if (!sock_is_scoped(other->sk, subject->domain, scope))
>  		return 0;
>  
>  	landlock_log_denial(subject, &(struct landlock_request) {
> -		.type = LANDLOCK_REQUEST_SCOPE_ABSTRACT_UNIX_SOCKET,
> +		.type = request_type,
>  		.audit = {
>  			.type = LSM_AUDIT_DATA_NET,
>  			.u.net = &(struct lsm_network_audit) {
