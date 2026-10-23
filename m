Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773031;
	b=0aTjZFxflAPu861/LCmtkHUB8eICd8t02gnE6Gs3NzkAv05DKxttFxKmJ2rKX7Y+CJqQ
	 hzkyKBygzeHgJT8vmhVLG8RPAHVOsRCm2hYDFw0o+LhMreBmUX/b6yjLdd6xQ7G5dluXM
	 cDO6mLtGx6ozmw56eIn6B4Z/X19SCYddnT3XnKDbM70mXd4BpeVe5y2wwlubTE2AvRLDo
	 fUmJLUuWJUtlVyXondNVptMrLM0Z0mcZvcPM3RiNbrWi+V8A2HliyA4n3pDrYEzPI+/8U
	 T2jCAGja/PpuffVURQNKdYESibv4TkglujiRQbcDjcJ7pQ30kDGZ3j0xZ9zmtAEYxzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
	b=IG2ywzPSyF4klKcd+5Icp6JTgkwUZ2cgpXgHZ/Bu25IId6VOX/u3x6kRBIFt0WI5Wb3m
	 K3pDWk6iNNADFBy1Mgo9QapwNACASN1jRTVFVweyq0/1YtACUVgTIX12BZvdA0cDknPcr
	 9G89cKC5kq/awqrTdrpfM2lniOVpl4EJqxsoPLdcuhFdnh1bD3c8WkbzsvrFg2QYuZW06
	 dQhaE+3iqa9HuoR7PMkc8u0eLcO8jwZMAp+z/uRUPdbjHnR+3FKwZv7Q3KHJRWz/aLSqv
	 w5L6ASxoTfsY2R8VsprB8zYOWRUS9jDMByX4FDYyG2jD7lcaODjlR0+wCg3/bDzLIQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Eg0DI9sn;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404A0606A321
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 16:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 404A0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Eg0DI9sn
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-533797e72e8so7051111cf.2
        for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792773030; x=1793377830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
        b=Eg0DI9snt5My0sv+YEzPYCpV+u/w6o3PwIj2s/JtkMmoJzU5N6Y3sQmwmrVs5eCfST
         5hCAkRXPtWyk7Xz4w6Ohk25k+nW14MWApZ7Ti9eDCuF1+lKap8MS0kEXmui2WkdM5LNY
         XM8UwR54MhqsMmExkuTv/ykzg4HPsgHPuCSrt5SBZvhYzzYhPWnEiO3r+UcIgutH78TX
         xid3EaYb7wg6IColU8rtKtETLMniDB/Xv5k/oBlXP79u2EZi8tSwNDzwqRoHORuvv9X5
         rcUudSTwhDjS6xTER0AnhlhCnbrikDMJFeD9aii676jErJ5argoG9qNRuJIVRHt4dGL1
         NxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792773030; x=1793377830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qz7r+A/D6KnqK0PO5YdI2E3CPVQcCuCNvAghnich9pU=;
        b=1cws/5iZBkrhN2J9T4L0Mhb7nEk+Os6Mpipe2i8OtJO//E/8B9m/FBXHca2+AFj6gN
         Gj4rsGEHlBlJHY4sXdOSzaxXk1lSO8SXhCnAWyvtEfyEWTGO56dlXZAo7akhXzGDj7zm
         d2JUvrZEAhS2QdDGkyxONZHaSYcqw+B16aYY341Wyq3kmEgFDA5pEsuy72GHlEWy59Hh
         K89TC8QkfiHpr6fKb0k4RXw94xOeAHRPToAzzaMuzg7ewYOwjdfbWhINIDABRI2PFd+t
         enmzsCz6YiCjGm9F4HyaxZP4L0CHwq4Vx4pGMM7PQJ5Okdt8LqOtUChzVb3ITNyckx2P
         HryQ==
X-Forwarded-Encrypted: i=1; AKwUvBzp/tSzqNBwroW+SiT888AVz9mJKPHQjqMjOlsFOHd2GZeapAR9OW9fDDFb2FYz0ocySVU6gYre8HZrviiGxrIAFx/2z5I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVzSdWRuiaMk06TLVdImlXAS8nc/Wo+AgzhSZYCrgQf03RmyJW
	6Ajt4rcCBi4DB55bt0zNTx0PLgB7GVwglSJatRaOHuc1bNTf+VY0mMTl+yZiDy/Etoo=
X-Gm-Gg: AYBFou2KmrkgV83nyXzRzGtN64X7Ig/8QHFLQs2LtxSEE9/Eq5vppUh1cwepKSbVFsS
	f3S+JPBUMVNXF19PIzGeJE+1cXyzy+v38Ibo5YWF7CF5edQu3IpM/sixuCitmsS9RvzbMhYwun0
	Exa5EL/01xqT0AMph6+pXF1CHoxBpPIW1U5mlvajRtcvLoKgAcS5YUF9g33TNAvBKENx4uvVAWQ
	AXb7R76tbnGKmhrx100zX9QNPl8TaEtdlOVtbOyG8W/7pDXNvKoaBx11MxMG6VNxtXc38IS4utj
	oXyoBBO2mWkBLXn6CXJCGs+TeTlls7T7wSRqioF16goeNNFNeMVXZfR0vurcOlQYl6DhYjh0UTA
	EVyAGWCkaSsMm+T6DmlULw2YOiiBpzzcz81qFumr9K0L026K1q1/PwHkjjmPgBnsr8koGkApsOP
	tNnYhToysBjU3INojj33VHhTTv/5MH2UWCdCcFp5jvj1S0paYBR5mEMGQfro6jBn+X2flBtLlQs
	k3RFFVEm/SLPl3kVyhDTM+3wfRsLlSs0itvums5AXo/KwkLPnuEXQH7QLDlrxbvoEmpRuoR
X-Received: by 2002:a05:622a:c86:b0:536:2e47:f5ab with SMTP id d75a77b69052e-536c2136769mr38971691cf.9.1792773029863;
        Fri, 23 Oct 2026 09:30:29 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53836c4c71fsm1340051cf.25.2026.10.23.09.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:30:28 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 23 Oct 2026 16:30:08 +0000
Subject: [PATCH v5 2/5] userns: don't let setns() lend CAP_SETFCAP
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
Message-Id: <20261023-b4-setfcap-userns-v5-2-0620223be951@toxicpanda.com>
References: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
In-Reply-To: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792773019; l=6171;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=n4GgDASw93W0W4hVR9BfgOUvZQHADy8KOEbGO3+EfSU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QP2Uui21+ven36CKL6xikVUA2x0eTMOw5aUJbW4U7EVNW7o1QZuGQlTLSPgO8CVPWQ1SorTk+55
 4NE3zF8AYyAc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Mapping uid 0 of the parent into a user namespace requires CAP_SETFCAP,
because a task in such a namespace can write file capabilities that are
honoured in the parent.  A task that is already in the namespace has a
full capability set there and can't be asked any more, so
verify_root_map() goes by what the creator had, now ns->setfcap_level.

But setns() lets other tasks in, and they get the full set as well:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  unshare(CLONE_NEWUSER)
                                    setns(A's user ns)
                                      allowed, euid == ns->owner
                                    write "0 0 1" to /proc/self/uid_map
                                      ns->setfcap_level is A's -> allowed

or, if A's namespace maps uid 0 already, B sets security.capability on a
file.  Either way B ends up with file capabilities that are honoured in
the initial namespace, which it could not have written there, nor in a
namespace it created itself.

Refuse setns() into a user namespace whose tasks can write file
capabilities for the root user of an ancestor that the joiner's
CAP_SETFCAP doesn't reach.  That is the case when the namespace maps
such a root user, or has no uid map yet and its parent maps one.
cred_may_setfcap_userns() checks it, and cred_setfcap_reaches() is the
comparison it and the later checks use.  Then every task in such a
namespace is entitled to what its setfcap_level says, and the checks on
the way to file capabilities can go by the namespace.

An idmapped mount can store a root user that the namespace doesn't map,
for example a "0 100000" container whose rootfs maps 100000 to host uid
0.  That is a deliberate setup and up to whoever creates the mount, so
it is not considered here.

The change in behaviour is that a task without CAP_SETFCAP gets -EPERM
when it tries to setns() into a user namespace that maps the root user
of an ancestor, and was created by a task whose CAP_SETFCAP reached that
far.  Containers that don't map host uid 0, tasks with CAP_SETFCAP, and
unprivileged users joining their own namespaces are not affected.

Link: https://lore.kernel.org/all/20261021-bioenergie-allheilmittel-undurchdringlichen-35666eb62cff@brauner/
Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/capability.h |  3 +++
 kernel/user_namespace.c    |  6 +++++
 security/commoncap.c       | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 026974a5111b..e4199b03668b 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -224,5 +224,8 @@ int cap_convert_nscap(const struct mnt_idmap *idmap, struct dentry *dentry,
 		      const void **ivalue, size_t size);
 
 int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns);
+bool cred_setfcap_reaches(const struct cred *cred, struct user_namespace *ns,
+			  int level);
+bool cred_may_setfcap_userns(const struct cred *cred, struct user_namespace *ns);
 
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index a5a94367600d..7bd3692c2f3e 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1390,6 +1390,12 @@ static int userns_install(struct nsset *nsset, struct ns_common *ns)
 	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/* Tasks in the namespace may have CAP_SETFCAP that counts outside of
+	 * it, so only let in tasks whose own counts as far.
+	 */
+	if (!cred_may_setfcap_userns(current_cred(), user_ns))
+		return -EPERM;
+
 	cred = nsset_cred(nsset);
 	if (!cred)
 		return -EINVAL;
diff --git a/security/commoncap.c b/security/commoncap.c
index 4f49dba65426..8a9d998b1897 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -158,6 +158,64 @@ int cap_setfcap_level(const struct cred *cred, struct user_namespace *ns)
 	return cred->user_ns->level + 1;
 }
 
+/**
+ * cred_setfcap_reaches - Check how far up CAP_SETFCAP of a cred reaches
+ * @cred: The credentials to use
+ * @ns: The user namespace to look from
+ * @level: The ->level of the ancestor of @ns it has to count in
+ *
+ * Return: true if CAP_SETFCAP of @cred counts in @ns and in its ancestors
+ * up to the one at @level.
+ */
+bool cred_setfcap_reaches(const struct cred *cred, struct user_namespace *ns,
+			  int level)
+{
+	return cap_setfcap_level(cred, ns) <= level;
+}
+
+/*
+ * The topmost ancestor of @ns whose root user tasks in @ns can write file
+ * capabilities for: within @ns->setfcap_level, and mapped into @ns, or into
+ * its parent while @ns has no uid_map yet.  NULL if there is none.  An
+ * idmapped mount can store other root users, but that is up to whoever sets
+ * up the mount.
+ */
+static struct user_namespace *setfcap_top(struct user_namespace *ns)
+{
+	struct user_namespace *seen, *p, *top = NULL;
+
+	if (ns->setfcap_level >= ns->level)
+		return NULL;
+
+	seen = READ_ONCE(ns->uid_map.nr_extents) ? ns : ns->parent;
+	for (p = ns->parent; p; p = p->parent) {
+		if (p->level < ns->setfcap_level)
+			break;
+		if (kuid_has_mapping(seen, make_kuid(p, 0)))
+			top = p;
+	}
+
+	return top;
+}
+
+/**
+ * cred_may_setfcap_userns - Check whether a cred covers what a userns can do
+ * @cred: The credentials to use
+ * @ns: The user namespace
+ *
+ * Tasks in @ns can have CAP_SETFCAP that counts in ancestors of @ns, see
+ * cap_setfcap_level().  Check that CAP_SETFCAP of @cred reaches as far up as
+ * tasks in @ns can make use of theirs.
+ *
+ * Return: true if it does.
+ */
+bool cred_may_setfcap_userns(const struct cred *cred, struct user_namespace *ns)
+{
+	struct user_namespace *top = setfcap_top(ns);
+
+	return !top || cred_setfcap_reaches(cred, ns->parent, top->level);
+}
+
 /**
  * cap_settime - Determine whether the current process may set the system clock
  * @ts: The time to set

-- 
2.55.0

