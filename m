Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110997;
	b=FxxOoY5cMq8Qf+I++9R0lnL3s018ti88XNgI5kfq/SlFOtvVKJNkuy0gGm9QDO6zGBPv
	 DZzo0jRNDwi6M1vJnXeDIOpduYsMkjkVjyIYGh4x1qSg8m3fWjiVIdQumOzb4uJElSmUn
	 t/0hUv2+CvStZjusUkBzvnM/ols0CsGhGRcDBvWzggmLr9i2V7uMY88aXsVbQMb+YlR5l
	 vocK0exewfMPnaIxa4W69nAsFJszqg2of4HV59Jwe+vofue/PIThF4S9cl2k+wgQ8lRGr
	 cmjP+RldLTht2bIYMW6tM1rqeTcET9UtAbLfpDhGCu+P2riRwtH6dTc+foGgN0Y112A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=MixBdKDrKWIaD4vR9pKSroN8iOV2wkRTMyRsaYekuV8=;
	b=3vdsLl6t3VEH+RSSRdxpuOfT2OKy0nkqRiH+CpEnAGFmd/6gB4sRcAC3UCATomeQNGL5
	 sga+/XzQfoF8wQo6S0kKn5j37B58OyesJJqcijB3Tnng8iZm7Sd3B6SJtAYbMhjpLwZeS
	 EkS7sD0z2mqjR9mDc5PPRYyLROktHcJT91gelFwDDnOBxjazuCSvCxBP3Yc8fsA8wmOxE
	 byWyq5RwPWmQnW+oLRnnzSVazLevAk0KTZT8UOih9Mj7Sco7Ow1nesKYsCm5Y3kDz1z6I
	 BV9AzolB50C4fLB6WdMtPSMyZHkhjYNx68NSivqabahFuGv2u/BjjwBVhJQLNFBaoQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=lpg837bN;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8AB606A32E
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 14:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA8AB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=lpg837bN
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eabf243d05so1642718e0c.2
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 07:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793110996; x=1793715796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MixBdKDrKWIaD4vR9pKSroN8iOV2wkRTMyRsaYekuV8=;
        b=lpg837bNIJsHJTuEVsqCG1OTSUyr7sKOSALrAZornbOQareP6pphXzI0xqcgRiUabz
         h9rVo237nBkbSHhIU/obsUFhS6Z6BKjtHLSHpzyOwk7Eq4MWib8cYoutu9O1pOCMNkiy
         5ynxg6LQRgOotRx4da++qpdn45QIEPEcviuziuIEYe0OWcjvq4RLKpFY89fh7UnhsjG5
         f/AAE7M7MjuBbRID6jeZpwXF8VuNsaFDCrdeaK+ulCxZiK8NMpaUyVDLG3VvWVW/9DgW
         ru6sSq7F7iseI508cluD42NOplgsplUEeyDz7ord9Lv2YIbWGTgosaoxEBrBTpBlKKrD
         gU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793110996; x=1793715796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MixBdKDrKWIaD4vR9pKSroN8iOV2wkRTMyRsaYekuV8=;
        b=YXuo1qX+N/smx9jmgGEvwBuKDy8xcZvWLceq3lPTLCbILM+eA6WtnEZT5R5VNtkYwt
         zoVxzYxutDmMrAcYNmUPyKWWIa6ipO5CWkZuyxQtEZtlmc22VHNzcnZDzmoy512A1IZY
         2pMYQGe8Kp3mOMJDYUDxC8Vq5ajW9BVPnNFvkwqCw/kpCERcRT9FqpOmBg2JIaOrpI39
         9t/vtAEghQe/J8U4KJWhphVv9O0J6knTiRQMt3WweENdR5RzsasV8oFThOHIyL0wtL7o
         i9gnufbmiSrSszlC8Ilmx2DDeBpa239OT4yh6o8ckOVKK4n+zHCSHI7zGKHyfTis1hSV
         HZcA==
X-Forwarded-Encrypted: i=1; AKwUvBzJG07hhrJJUQpZKeh1D2FMzZLGrUwvDEqFMIk5ldPzpxxKeLw3lwsgosm1zGUFRcFg/u5/SBWuKv4eEnzA8BQxX6flU5w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKaVv6ii85wHEcGBNCnvkoOOeCK16fTZM2XAsqPDI0lE86udB/y
	cCghb3LCnAJA6aHUsWPIYYwpUhjil+Qul3t4PmEwQXqD2PYVVBAC5TD5oKDS6TD5GJY=
X-Gm-Gg: AYBFou0i/6+QgKNx374WyPfMYhQyXH1A14qZfDjoCqiS98uhI3XFCQpMOAydngYQJbp
	wojBvLHRvTCGrVxamt+ggzpr3td/mwaNv4dbj4e+1Uf9VDWgxQjihrfo3P5dQTR16/qaGBlzyjK
	itZc+woOQQHGz36I9QTtfb9C11Eghgw+LoShq2QhZ77X7NRyQucQHvxYaRqrBkn/V8JheBUUVAt
	Ly+K8vaB7tRoT00Oc0eEh/dAFmABxtkPEs4YURhDeST9Kup7MlDT8072/6y0YDu10pmHGVjecxb
	oOgOpXxANUdd8WMgitMmN/yEKQ7c0C8zMnaSSt+AvOcDc58XO0LHVHeiJOtaTDMMZ5r+ums1HSv
	YQr4KpyV2TJvyQKPGzlEhkZrf1gqWbHF2P/BTMksN+zFUw/wjLGFiFmrRRRrcCC3dnikQibIQ9r
	aBT2jWz+TGroMRcVVc+AVMLrWGbkffj7cGRG1qcWCE/RaR9mwz3lG+gIZVcOzLOdIsZvnge9Nz9
	0aCN9jqS0q5z5uSf/y+Omaz6iwKlKTOrjP1UfKxgHYlg2TuMx+RR1dnbTt4dINqRrhbfK8J
X-Received: by 2002:a05:6122:1790:b0:5e7:e3f9:1322 with SMTP id 71dfb90a1353d-5ec23288d76mr3909423e0c.9.1793110995603;
        Tue, 27 Oct 2026 07:23:15 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9912da2d9d1sm75077241.7.2026.10.27.07.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:23:15 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 27 Oct 2026 14:22:51 +0000
Subject: [PATCH v8 3/6] userns: check the opener and the writer before
 mapping uid 0
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
Message-Id: <20261027-b4-setfcap-userns-v8-3-2674adc63f3c@toxicpanda.com>
References: <20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com>
In-Reply-To: <20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com>
To: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>, 
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793110987; l=6694;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Tq4QC700hpQ0XsVb6nesQjcXMRFBl8Nnhz0SoKNdw/Q=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDnI6R4VZy9xB9YQWBhtA8maRIyE4iwcJt2G/vdLCu+bEMVbGxtZDjvHN7mZchCF2DqoX2Se+YM
 NJf8JkgsCHwE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

verify_root_map() looks at the cred that opened the map file: it asks
whether it has CAP_SETFCAP over the parent, or, for an opener inside the
namespace, whether the creator had.  Two things are missing.

The writer isn't checked.  For every other privileged mapping
new_idmap_permitted() wants the capability from the opener and from the
task that calls write(), but a map that consists of the single line
"0 0 1" takes the unprivileged branch, where only the opener's euid
counts.  So an open uid_map file is a token for mapping uid 0:

  task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
  fd = open("/proc/<pid>/uid_map")
  B gets fd by inheritance
  or SCM_RIGHTS
                                    write(fd, "0 0 1")
                                      opener had CAP_SETFCAP -> allowed

And the check only happens for a map with an extent that starts at the
parent's uid 0, and only asks for CAP_SETFCAP over the parent.  But the
root user of an ancestor can be mapped into the parent at any uid, and
the parent's own root user can be the root user of ancestors further up.
A task without CAP_SETFCAP that unshared a namespace, which a privileged
task then mapped "1000 0 1" for, can unshare again and map "0 1000 1":
host uid 0 is uid 0 of the new namespace, and nothing was checked.

Find every ancestor whose root user the new map contains, at whatever uid
it has in the parent, and require that the opener and the writer both
reach the topmost of them.  A task outside the namespace that is being
mapped needs CAP_SETFCAP over the parent, reaching that far by
cap_setfcap_level().  A task inside it needs CAP_SETFCAP there, and
ns->setfcap_level has to reach that far: a task in the namespace that
gave up CAP_SETFCAP would otherwise map uid 0 and get it back from
execve().

This only affects maps that contain the root user of the parent or of
one of its ancestors.  A write by a task without CAP_SETFCAP to a file
opened by one with it, and a map by a task whose CAP_SETFCAP stops short
of the root user it passes on, now fail with -EPERM.

Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/user_namespace.c | 87 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 64 insertions(+), 23 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 7bd3692c2f3e..db078dd6406a 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -881,15 +881,55 @@ VISIBLE_IF_KUNIT int uid_gid_map_sort(struct uid_gid_map *map)
 }
 EXPORT_SYMBOL_IF_KUNIT(uid_gid_map_sort);
 
+static bool map_has_id(struct uid_gid_map *map, u32 id)
+{
+	struct uid_gid_extent *extent;
+	int idx;
+
+	for (idx = 0; idx < map->nr_extents; idx++) {
+		if (map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
+			extent = &map->extent[idx];
+		else
+			extent = &map->forward[idx];
+		if (id >= extent->lower_first &&
+		    id - extent->lower_first < extent->count)
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * The lowest ->level among @parent and its ancestors whose root user @new_map
+ * maps, whatever uid that root user has in @parent; INT_MAX if there is none.
+ */
+static int map_root_level(struct user_namespace *parent,
+			  struct uid_gid_map *new_map)
+{
+	struct user_namespace *p;
+	int level = INT_MAX;
+	uid_t id;
+
+	for (p = parent; p; p = p->parent) {
+		id = from_kuid(parent, make_kuid(p, 0));
+		if (id != (uid_t)-1 && map_has_id(new_map, id))
+			level = p->level;
+	}
+
+	return level;
+}
+
 /**
  * verify_root_map() - check the uid 0 mapping
  * @file: idmapping file
  * @map_ns: user namespace of the target process
  * @new_map: requested idmap
  *
- * If a process requests mapping parent uid 0 into the new ns, verify that the
- * process writing the map had the CAP_SETFCAP capability as the target process
- * will be able to write fscaps that are valid in ancestor user namespaces.
+ * If a process requests mapping the root user of the parent ns, or of one of
+ * its ancestors, into the new ns, verify that the process that opened the map
+ * file and the process writing the map had the CAP_SETFCAP capability as the
+ * target process will be able to write fscaps that are valid in ancestor user
+ * namespaces.
  *
  * Return: true if the mapping is allowed, false if not.
  */
@@ -897,42 +937,43 @@ static bool verify_root_map(const struct file *file,
 			    struct user_namespace *map_ns,
 			    struct uid_gid_map *new_map)
 {
-	int idx;
 	const struct user_namespace *file_ns = file->f_cred->user_ns;
-	struct uid_gid_extent *extent0 = NULL;
-
-	for (idx = 0; idx < new_map->nr_extents; idx++) {
-		if (new_map->nr_extents <= UID_GID_MAP_MAX_BASE_EXTENTS)
-			extent0 = &new_map->extent[idx];
-		else
-			extent0 = &new_map->forward[idx];
-		if (extent0->lower_first == 0)
-			break;
-
-		extent0 = NULL;
-	}
+	int level;
 
-	if (!extent0)
+	level = map_root_level(map_ns->parent, new_map);
+	if (level == INT_MAX)
 		return true;
 
 	if (map_ns == file_ns) {
 		/* The process unshared its ns and is writing to its own
 		 * /proc/self/uid_map.  User already has full capabilites in
-		 * the new namespace.  Verify that the parent had CAP_SETFCAP
-		 * when it unshared.
+		 * the new namespace.  Verify that it still has CAP_SETFCAP
+		 * there, and that the parent had it when it unshared, as far up
+		 * as those root users go.
 		 * */
-		if (file_ns->setfcap_level >= file_ns->level)
+		if (!file_ns_capable(file, map_ns, CAP_SETFCAP) ||
+		    file_ns->setfcap_level > level)
 			return false;
 	} else {
 		/* Process p1 is writing to uid_map of p2, who is in a child
 		 * user namespace to p1's.  Verify that the opener of the map
 		 * file has CAP_SETFCAP against the parent of the new map
-		 * namespace */
-		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP))
+		 * namespace, and as far up as those root users go.
+		 */
+		if (!file_ns_capable(file, map_ns->parent, CAP_SETFCAP) ||
+		    !cred_setfcap_reaches(file->f_cred, map_ns->parent, level))
 			return false;
 	}
 
-	return true;
+	/* The file may have been handed to someone else since it was opened,
+	 * so the same goes for the process that is doing the write.
+	 */
+	if (map_ns == current_user_ns())
+		return ns_capable(map_ns, CAP_SETFCAP) &&
+		       map_ns->setfcap_level <= level;
+
+	return ns_capable(map_ns->parent, CAP_SETFCAP) &&
+	       cred_setfcap_reaches(current_cred(), map_ns->parent, level);
 }
 
 /*

-- 
2.55.0

