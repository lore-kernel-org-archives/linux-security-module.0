Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79D2423E9E;
	Fri, 25 Sep 2026 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343284; cv=none; b=Sl55cVy29bIu21UXPa6pqdTE4aZqQEiNY7JhuklbB0uSXXGQlpRnD6OkVKk1ykpHt2OdlI3xAaIK/950XaIPbQOzwVNXjkAn0Vr73U1PgupAVuKIAvNr5xTJ/ASo3RHfSFhA3AVZ9M144HdnY3ZBFpSmrWyQDKU95REO/ZiJZwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343284; c=relaxed/simple;
	bh=0vielYZed4HV7XfW82om9xTVqeGDlpkgGTZ1SIoqWNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXYIGAJ2As4r+Sy0FKXts9/yfrUcUR9Mw6vb0GdUQxZO0U8SFT7+dVOEVN4Gf4Qxzs3YBwOHdq126a8EWkZ0eJD2T6wT1D/FtewF6fPU7k+Ru4eIP0SycuHiuctgWiw45Yw/961XL7r1wvz6agfeGgYRQakFvg4BQ9H9Ge2X71Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=I4Yw7KLX; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="I4Yw7KLX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=682gjvnHozUTQ/G+7ht1Fk/nN9QjqnhUXggkVz8k2/g=; b=I4Yw7KLX+JIR
	9XiEqgZ6EHl+v6tAAviFE0n2F3p65dcGLP6Ptz0K0kg+BfqEZGQUoYzkIlA4CetaXm+Li/yqIRwfB
	q62iyyp1OF/ahPrCqAx9YIFT/LJzoHAXPuEuBBd4dNd/KLWX5RInKbTT7drcz2CpwblBfJtF7YrtK
	26+pkSITaWRYLgkqetyB4TZngfrSPTKvgiH8b2qp9GBO5Qe8gFW1C8K+o/CR3OAfwSy1alMlFTphv
	GEHMUNpsWk2EeBjQJM/nyDuhlg4nTMIYQkxhPd5t05RMMaLb9aVHBDBVu+d6pADWxMU/71kV0X58Q
	Fhd1c3w/hpbvoAB47v0FcA==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=LekKit-T14)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <eva.kurchatova@virtuozzo.com>)
	id 1xA61W-008SRE-1i;
	Fri, 25 Sep 2026 15:34:34 +0200
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
To: Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: linux-kernel@vger.kernel.org,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	linux-kselftest@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] selftests: binderfs: skip the stress test without binderfs
Date: Fri, 25 Sep 2026 16:34:07 +0300
Message-ID: <20260925133435.3635453-1-eva.kurchatova@virtuozzo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

binderfs_stress mounts binderfs and asserts on the first mount, so on
a kernel without CONFIG_ANDROID_BINDERFS the case fails rather than
reporting that the filesystem is not there.

Ask /proc/filesystems whether the kernel has it, the way
supports_filesystem() in the landlock tests and check_resctrlfs_support()
in the resctrl ones already do, and skip when it does not.

Probing with a mount instead would not work here: the test is meant to
run unprivileged, and path_mount() rejects an unprivileged caller in
may_mount() before do_new_mount() ever looks the filesystem type up, so
the probe would see EPERM whether binderfs is there or not. The child
would then still reach the real mount inside its userns and fail.

Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
---
 .../filesystems/binderfs/binderfs_test.c      | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index a1a79a6fef17..70f0391136c4 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -36,6 +36,28 @@
 		fd = -EBADF;        \
 	}
 
+static bool binderfs_supported(void)
+{
+	char line[128];
+	bool ret = false;
+	FILE *f;
+
+	f = fopen("/proc/filesystems", "r");
+	if (!f)
+		return true;	/* Cannot tell, let the test run and report. */
+
+	while (fgets(line, sizeof(line), f)) {
+		/* binderfs has no backing device, hence the "nodev" prefix. */
+		if (!strcmp(line, "nodev\tbinder\n")) {
+			ret = true;
+			break;
+		}
+	}
+
+	fclose(f);
+	return ret;
+}
+
 static void change_mountns(struct __test_metadata *_metadata)
 {
 	int ret;
@@ -388,6 +410,9 @@ TEST(binderfs_stress)
 	char binderfs_mntpt[] = P_tmpdir "/binderfs_XXXXXX",
 		device_path[sizeof(P_tmpdir "/binderfs_XXXXXX/") + BINDERFS_MAX_NAME];
 
+	if (!binderfs_supported())
+		SKIP(return, "The Android binderfs filesystem is not available");
+
 	ret = socketpair(PF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, syncfds);
 	ASSERT_EQ(ret, 0) {
 		TH_LOG("%s - Failed to create socket pair", strerror(errno));
-- 
2.55.0

