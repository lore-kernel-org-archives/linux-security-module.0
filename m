Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFD139E16C
	for <linux-security-module@vger.kernel.org>; Fri,  3 Jul 2026 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092488; cv=none; b=stcA3YDHd5WeLGdWeL+4J8TB8ESS7CnDK2kqQfuFe6ggHa+temARE6iEIYdBLCIXR5zkKNujfYhC2v+5zBH5MynAY8gDI19VYTF9z7ibhQ2ylz0U3UP5+4Fee0eHY4LPjb2INWonQh+LIzhkKWCpaHY4gUfw8M0X3RYx6iELfc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092488; c=relaxed/simple;
	bh=rKU9w6uMdwdxWVfNlP3Mm5GV7AB4Y5MS7R2cMjRfQnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z7JbdBo2Ry5pQkWluT7VmFimU0jCx0UUZiDiwiq9BXKi4w/tG5GqcoNwMjfrAt79atZERvbsdFIsDClutAM83wT/ssY6PNdy0x1Uv22mL0lWp/35w6lKJH2OeAPN+cKPOg3dcc2/MqnsgxmULj+2jC8DJ8NlnIZJWrKQ+b9TPMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=E/gD2U7I; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="E/gD2U7I"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gsHgw510LzwBK;
	Fri,  3 Jul 2026 17:27:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1783092476;
	bh=A88ZN7w7eYWOkzYuzJF4p0R1RwagheMg+dPPbmJ6roI=;
	h=From:To:Cc:Subject:Date:From;
	b=E/gD2U7IKzQUp4y5VUIyZo2dh6GbGasG0WZqTOn4kYuXuC5ZbHdHXZxcl+/0BKQnw
	 hdmu7cJ9TfWXlW0sQA79evLE1P3LSlx4lehAUltniJ8l4UAP0pVB7KwKAueQ2n8xmb
	 Gk1Rl3uQZ5X/2DpHE/SW+fS0+j4z2AOpxZzfayqQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gsHgv5cx4zsl9;
	Fri,  3 Jul 2026 17:27:55 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Matthieu Buffet <matthieu@buffet.re>
Subject: [PATCH v1] landlock: Harden sock_is_scoped() against file-less sockets
Date: Fri,  3 Jul 2026 17:27:48 +0200
Message-ID: <20260703152750.2022878-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

sock_is_scoped() dereferences other->sk_socket->file->f_cred to read the
peer's Landlock domain when evaluating
LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET, without first checking that the
peer has a backing socket and file.  hook_unix_find() performs the same
dereference for LANDLOCK_ACCESS_FS_RESOLVE_UNIX and does guard it.
Guard it here too and treat a peer with no backing file, such as a
kernel socket created by sock_create_kern(), as unscoped.

This is defensive hardening, not a fix for a reachable bug.  The
unix_stream_connect() and unix_may_send() hooks run with the peer held
under unix_state_lock() and only after the AF_UNIX core has excluded
SOCK_DEAD, and no in-tree code binds a file-less AF_UNIX socket to an
abstract address, so other->sk_socket->file is always valid at these
call sites today.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/task.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/security/landlock/task.c b/security/landlock/task.c
index 7ddf211f75c3..474642edbd59 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -243,6 +243,17 @@ static bool sock_is_scoped(struct sock *const other,
 
 	/* The credentials will not change. */
 	lockdep_assert_held(&unix_sk(other)->lock);
+
+	/*
+	 * A live kernel socket (e.g. from sock_create_kern()) has no backing
+	 * file, hence no Landlock domain, so treat it as unscoped.  The
+	 * sk_socket check only guards that dereference; sk_socket is NULL
+	 * solely for a dead peer, which the caller already excludes under the
+	 * held lock, so no separate SOCK_DEAD check is needed.
+	 */
+	if (unlikely(!other->sk_socket || !other->sk_socket->file))
+		return false;
+
 	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
 	return domain_is_scoped(domain, dom_other,
 				LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET);

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.54.0

