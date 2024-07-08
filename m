Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128AF1DDF4
	for <linux-security-module@vger.kernel.org>; Mon,  8 Jul 2024 19:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720468365; cv=none; b=OEsUKknDHao/xHMwJJ1Mv73RKHS0EdMeLwrKtgm3nybCRN4F87XS7t3SRrUfcLqYS76vTrRLpGol4Vlc4xpYdHII7DDapw3K1FGsmmQsi5E9yeMXmzxE1v9ztkqlRN4f6obycouNOCV9e7FyK0sECnI8uhf3BJj6jVKTJBa6YUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720468365; c=relaxed/simple;
	bh=f6J3SyMoDlZnX07mleC15lOwC8e7IIONVGk8M5fMiVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQxUttGwMeiBjKE+mMKeX3vDgeo84mc6daibzLoqJ7i39Tf0c0qjAIdKi3OiNRcVpFOY3XGjzjB1l8wnGhQQab6HSG1JMjTU7OwqSMNhGw1pJXv3161GB7WKNwxmuxEEXvOh8jzgziAgOHS1DmlBQU1pJZJeXf+3QfkKqIrpj7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=14o6G+kt; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="14o6G+kt"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WHvkC0RZ8zTJk;
	Mon,  8 Jul 2024 21:45:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720467954;
	bh=ilehYGP+q5fwPfEBN5/iUyPlmWRy6d513iG8m2WrmI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=14o6G+ktpNaLu4raXbCfVq0pepd/8UsG3XShk47o7zGTN4rGazuD5syQSYmnD2Ihg
	 HDnlDIQIBwCMAmSJvEgcJrk1d4Vl4+PGEy4YdG4h/kYYXX1STAfivnR+7paePaMWTU
	 7u8oCJK5OknQp9bCFzbLfNGwFSuL0rNel1zR3/IY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WHvkB1W56zm5b;
	Mon,  8 Jul 2024 21:45:54 +0200 (CEST)
Date: Mon, 8 Jul 2024 21:45:42 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Jann Horn <jannh@google.com>, outreachy@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v1] landlock: Abstract unix socket restriction tests
Message-ID: <20240708.rootai6weiXe@digikod.net>
References: <Zn32KKIJrY7Zi51K@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zn32KKIJrY7Zi51K@tahera-OptiPlex-5000>
X-Infomaniak-Routing: alpha

These are good tests!  However, I get errors when running some of them (using
the latest formatted patches):

#  RUN           unix_socket.allow_without_domain_connect_to_parent.abstract_unix_socket ...
# ptrace_test.c:845:abstract_unix_socket:Expected 0 (0) == bind(self->server, (struct sockaddr *)&addr, addrlen) (-1)
# abstract_unix_socket: Test terminated by assertion
#          FAIL  unix_socket.allow_without_domain_connect_to_parent.abstract_unix_socket
not ok 9 unix_socket.allow_without_domain_connect_to_parent.abstract_unix_socket
#  RUN           unix_socket.allow_without_domain_connect_to_child.abstract_unix_socket ...
# ptrace_test.c:793:abstract_unix_socket:Expected 0 (0) == bind(self->server, (struct sockaddr *)&addr, addrlen) (-1)
# ptrace_test.c:826:abstract_unix_socket:Expected 1 (1) == read(pipe_child[0], &buf_parent, 1) (0)
# abstract_unix_socket: Test terminated by assertion
#          FAIL  unix_socket.allow_without_domain_connect_to_child.abstract_unix_socket
not ok 10 unix_socket.allow_without_domain_connect_to_child.abstract_unix_socket


On Thu, Jun 27, 2024 at 05:30:48PM -0600, Tahera Fahimi wrote:
> Tests for scoping abstract unix sockets. The patch has three types of tests:
> i) unix_socket: tests the scoping mechanism for a landlocked process, same as
> ptrace test.
> ii) optional_scoping: generates three processes with different domains and tests if
> a process with a non-scoped domain can connect to other processes.
> iii) unix_sock_special_cases: since the socket's creator credentials are used for
> scoping datagram sockets, this test examine the cases where the socket's credentials
> are different from the process who is using it.
> 
> Closes: https://github.com/landlock-lsm/linux/issues/7
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---

> +/* clang-format off */
> +FIXTURE(optional_scoping)
> +{
> +	int parent_server, child_server, client;
> +};
> +/* clang-format on */
> +
> +/* Domain is defined as follows:
> + * 0 --> no domain
> + * 1 --> have domain
> + * 2 --> have domain and is scoped

You should use an enum instead of these hardcoded values.  This is
better to understand/document, to review, and to maintain.

> + **/
> +FIXTURE_VARIANT(optional_scoping)
> +{
> +	int domain_all;
> +	int domain_parent;
> +	int domain_children;
> +	int domain_child;
> +	int domain_grand_child;
> +	int type;
> +};
> +/*
> + * .-----------------.
> + * |         ####### |  P3 -> P2 : allow
> + * |   P1----# P2  # |  P3 -> P1 : deny
> + * |         #  |  # |
> + * |         # P3  # |
> + * |         ####### |
> + * '-----------------'
> + */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(optional_scoping, deny_scoped) {
> +	.domain_all = 1,
> +	.domain_parent = 0,
> +	.domain_children = 2,
> +	.domain_child = 0,
> +	.domain_grand_child = 0,
> +	.type = SOCK_DGRAM,
> +	/* clang-format on */
> +};
> +/*
> + * .-----------------.
> + * |         .-----. |  P3 -> P2 : allow
> + * |   P1----| P2  | |  P3 -> P1 : allow
> + * |         |     | |
> + * |         | P3  | |
> + * |         '-----' |
> + * '-----------------'
> + */
> +/* clang-format off */
> +FIXTURE_VARIANT_ADD(optional_scoping, allow_with_domain) {
> +	.domain_all = 1,
> +	.domain_parent = 0,
> +	.domain_children = 1,
> +	.domain_child = 0,
> +	.domain_grand_child = 0,
> +	.type = SOCK_DGRAM,
> +	/* clang-format on */
> +};

I guess this should failed with the current kernel patch (see my review
of the kernel patch), but something like that should be tested:

FIXTURE_VARIANT_ADD(optional_scoping, allow_with_one_domain) {
	.domain_parent = 0,
	.domain_child = 2,
	.domain_grand_child = 0,
};

grand_child should be able to connect to its parent (child), but not its
grand parent (parent).
