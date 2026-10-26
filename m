Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008658;
	b=AKt0IYevbs7epGI3HnXd4IKQrFOwgvYwXhWCz12SmEEqj3po9kbnpi/Qt/xIqV1zZVVx
	 Y5rljqLttzNJDffRok2U1DthByxpA0vAMhdO6kuzh+RI6R/5OZAJqFmtf5yB4ggKsFVdc
	 x0OckAEWaUfqcJ67Y9f/4CZDeh62LlYn0fD5Cya/cdDHKAAOb1dEU1GIlbQ40NrkBipKF
	 9ZZOxLHTSs89Jp6S+PRgCd+ff2bmo3ZGhvzujYY3AS/3vBUwGWGq+1eSzj96rrReIsdwF
	 oZhvku8HHIRg6pzDnAwUWIcfjfZ4g4HQ/1rZLeusqAQta/KsZ4SwRPfRXHcVZ3maRrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008658;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=94/uRgd7GeQgvvGKNpX5Ob9HjJrUmtssxMWgQ2nxxfw=;
	b=mfaC9PS7R+clAllsny2aDNMCTXA9DnL46BO+hnnC8ZCGpGQQ5wT5LFeT1jn21SWexZ9E
	 nfGA2V2/RmjayPQN6JDD3begBxnMy96Kqccmp+JCO703lSs5F73nRby75WqFKRYODrBmr
	 F4aF4wpaqA6SPlXlPYutoAFPGutlGBmxZUjXBWJkI1SGyVGiBGx37ZRhNIUO6u+uUt9ZB
	 bYxnXdqvBL/X/sqQUNbehiwxe3phJk4w0RWyD9K0hj83vH06DQIon4jgv9eSbw03qXae9
	 Sjdw4gfOWc7h1TmpmCX+az5O4V3Q2XplF6H4pbq4M+CfTc04zBU1UP4g965Sxylul/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRIWsQuw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC928606A33B;
	Mon, 26 Oct 2026 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRIWsQuw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643AC1F01825;
	Mon, 26 Oct 2026 09:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008657;
	bh=94/uRgd7GeQgvvGKNpX5Ob9HjJrUmtssxMWgQ2nxxfw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NRIWsQuwwsgJOn5OWf/nexIc8OF/thgbnqOD5JxFyznoUHZUy2K1NCiIrMH8EGDH1
	 C5MbRJl1JFQnMIXCNCaDHmVORaylva/SNnGzsTUeiO06OGPKuaYoen5Ibf+J7t7Sl1
	 CX34m2of6vL5jQp/skox9wXwBohjdAazFWT5TzgQyY2UkGLA6OICA7+Ch8thTSxcbl
	 M+ibNVPF4I73tMFCK3BCwaa2/OHT+JExs82qM3o/MjM3kR4qcE1hlgeBVzhgRt08m+
	 fc3npv+almeLIcWm6xp15PvaPQrGEG23YQkruHiSm6j3sceDlGUUx94akaQqQnTIgz
	 juu890YHZg7ww==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 26 Oct 2026 10:57:12 +0100
Subject: [PATCH 4/8] landlock: pass the namespace id to log to
 check_ns_type()
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-work-security-namespace_free-v1-4-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
In-Reply-To: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
To: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2795; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3F61DKwmzzuwS61c6sCKEvTMKrGpvnjYTNdO7GdJgDw=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGrfJAKiapYXjjOFUd5UEiZ4C6u3Ig4kq52o7dIy6dC+LwCN6
 Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmrfJAIACgkQkcYbwGV43KJbiwEAtpK8
 apRqEDzYZFM3CwqByDapQYIhDQThVaQPCZOs/+kBAMIMa4iix2w4azXvf5ja8zStAtp6YS9V+ke
 o9IZ+U68F
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Landlock logs the namespace id when it denies the use of a namespace.
check_ns_type() takes it from the namespace itself. When it is called
from the namespace_init hook the id is always zero as it is only
allocated after the hook has run.

A follow-up patch will allocate the id before the namespace_init hook is
called. But a namespace whose creation is denied never becomes visible
and the Landlock documentation says that namespace_id is zero for
namespace creation (cf. Documentation/admin-guide/LSM/landlock.rst and
Documentation/trace/events-landlock.rst). So pass the id to log to
check_ns_type() and keep passing zero from hook_namespace_init().

No functional changes.

Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
Cc: <stable@kernel.org> # mainline only
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 security/landlock/ns.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/landlock/ns.c b/security/landlock/ns.c
index cd44c927f83a..39795c4e1404 100644
--- a/security/landlock/ns.c
+++ b/security/landlock/ns.c
@@ -90,15 +90,16 @@ static const struct access_masks ns_permission = {
  * check_ns_type - Check namespace use permission
  *
  * @ns: The namespace being allocated or installed.
+ * @ns_id: The namespace id to log.
  *
  * Shared check for namespace_init (creation via clone(2), unshare(2),
  * open_tree(2), or fsmount(2)) and namespace_install (use via setns(2)): denies
  * when the namespace type is not in the domain's allowed set.  At allocation
- * time @ns->ns_id is still zero and is logged as such.
+ * time the namespace isn't visible yet so @ns_id is zero.
  *
  * Return: 0 if allowed, -EPERM if denied.
  */
-static int check_ns_type(struct ns_common *const ns)
+static int check_ns_type(struct ns_common *const ns, const u64 ns_id)
 {
 	const struct landlock_cred_security *subject;
 	size_t denied_layer;
@@ -121,7 +122,7 @@ static int check_ns_type(struct ns_common *const ns)
 				    .permission =
 					    LANDLOCK_PERMISSION_NAMESPACE_USE,
 				    .audit.u.ns.ns_type = ns->ns_type,
-				    .audit.u.ns.ns_id = ns->ns_id,
+				    .audit.u.ns.ns_id = ns_id,
 				    .layer_plus_one = denied_layer,
 			    });
 	return -EPERM;
@@ -129,13 +130,13 @@ static int check_ns_type(struct ns_common *const ns)
 
 static int hook_namespace_init(struct ns_common *const ns)
 {
-	return check_ns_type(ns);
+	return check_ns_type(ns, 0);
 }
 
 static int hook_namespace_install(const struct nsset *const nsset,
 				  struct ns_common *const ns)
 {
-	return check_ns_type(ns);
+	return check_ns_type(ns, ns->ns_id);
 }
 
 static struct security_hook_list landlock_hooks[] __ro_after_init = {

-- 
2.53.0

