Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215434;
	b=1jGNjQYBo72gyBM0yLPnn3lIs9jVu3vc0qLgy2Eu1mp56GfuhE5d8GOOQ+A+jEv3nWLq
	 5cEOzpQDV9ovF+eYWzxT9B5Cism0vVQCpYL0+0TA+5qCICqCeWbhUfIwS5dT5J7dGjcZN
	 DXhrpy+/UW3KfTA74rCa3BtHNO5M/UVJOBeTWI96KUxz/eGASis+7qTP5h0juic6UooWh
	 yiTiEIndz6z3auATcDwZWYBsLdSawVsLM2Sk/UVZdEwJSuOz+Lernhc+HyFiIucF+USzw
	 AqVitCWzYpGdhIwdX1aKGt/dqLTBDxdgsu+EMujmh8nAFniIMUHLJTmL0qvFbC2SoTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215434;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=+MeXvDM49lBydfITuDJUBOPgWBRXm14pVWPP6R2iYmc=;
	b=2tUpDr3Z8G3hkrMgVsVw6FZtrrTLJLYGAMe868+Uz9iYwSwWs6qLpiutFVwnI2j4qTLQ
	 o2YdLmzGRkdo/pYGro8X+Vv6o9RDmnSHrV7KfvkPZ+ziBd+dENYHUf09v+7UUn1Yv96nO
	 RBtgUJmb8kUFa5bVogbZROxAbsAUN55tc82WyUNFalcJfKZyU1hO6JAoEn6z7dgokp4O4
	 /fDVmOXSO6tahIhBKSFx4sFRRBXnSDU8rsANUAjHayJdQPfDj2ly8ZS7DGjQCKRNG6y3C
	 zOmyiyLbiNVkInSWDivAHJJ1jY6r0q9lNNNxtwx7JZ2i3WHNYlG5g8gow2F4pqCzhVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=eizUf1gF;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937A0606A31C;
	Mon,  9 Nov 2026 09:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 937A0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=eizUf1gF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+MeXvDM49lBydfITuDJUBOPgWBRXm14pVWPP6R2iYmc=; b=eizUf1gF9fCRVri2Az0/KT27JN
	eOWo/pJIcZHCywMWgVT9JYtvxAEHiw2hGcK9g6IIO6KAGN0Qarfckd187Y/mdjvJvYlJJFnzGN8q9
	MlQzPew98qNmoBp7/Hwtga2fVxN764Il4K6ZYD4HvjQsUo/t99KBnLqKu1PLzyM8kDarijyJDjPgI
	JqZdMmUBDrguKP29nhGxxVKTXkIeQ4/MSSCKz0jywcmpbrMa+EOgXgyzNJBREgi3PR7cPht1B3yiw
	AMaMDRbyTQF/hSx2SUlcBnIeBaHdgpy+TTKh+4BHplZoq8pj1i7iBi6HduqSLxtPhxbk7WqFfakgb
	xEhQXr4Q==;
Received: from [::1] (port=34256 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1xQLOa-000000082RX-0thS;
	Mon, 09 Nov 2026 10:10:31 +0100
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 09 Nov 2026 10:10:29 +0100
From: nicolas.bouchinet@oss.cyber.gouv.fr
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: xiujianfeng@huawei.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, shuah@kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next 9/9] selftests/lsm: add lockdown securityfs test
In-Reply-To: <20261103082421.3033195-10-caixinchen1@huawei.com>
References: <20261103082421.3033195-1-caixinchen1@huawei.com>
 <20261103082421.3033195-10-caixinchen1@huawei.com>
User-Agent: Roundcube Webmail/1.6.20
Message-ID: <c6d5859bae92370d6c9e0a8b4b0c50d1@oss.cyber.gouv.fr>
X-Sender: nicolas.bouchinet@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Le 2026-11-03 09:24, Cai Xinchen a écrit :
> Add a kselftest for the lockdown securityfs interface.  It checks the
> read format, rejects unknown levels, and verifies that an already 
> locked
> down kernel neither accepts the current level nor a lower one.  The 
> test
> skips itself when lockdown is not enabled, when not run as root, or 
> when
> the file cannot be opened for writing, and it never escalates lockdown
> on the test machine.
> 
> Use the shared file read helper from common.c instead of duplicating 
> it.
> 
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
> ---
>  tools/testing/selftests/lsm/Makefile        |   3 +-
>  tools/testing/selftests/lsm/common.c        |  35 +++-
>  tools/testing/selftests/lsm/common.h        |   2 +
>  tools/testing/selftests/lsm/lockdown_test.c | 176 ++++++++++++++++++++
>  4 files changed, 206 insertions(+), 10 deletions(-)
>  create mode 100644 tools/testing/selftests/lsm/lockdown_test.c
> 
> diff --git a/tools/testing/selftests/lsm/Makefile 
> b/tools/testing/selftests/lsm/Makefile
> index 3f80c0bc093d..737e8686bb7d 100644
> --- a/tools/testing/selftests/lsm/Makefile
> +++ b/tools/testing/selftests/lsm/Makefile
> @@ -6,12 +6,13 @@ CFLAGS += -Wall -O2 $(KHDR_INCLUDES)
>  LOCAL_HDRS += common.h
> 
>  TEST_GEN_PROGS := lsm_get_self_attr_test lsm_list_modules_test \
> -		  lsm_set_self_attr_test
> +		  lsm_set_self_attr_test lockdown_test
> 
>  include ../lib.mk
> 
>  $(OUTPUT)/lsm_get_self_attr_test: lsm_get_self_attr_test.c common.c
>  $(OUTPUT)/lsm_set_self_attr_test: lsm_set_self_attr_test.c common.c
>  $(OUTPUT)/lsm_list_modules_test: lsm_list_modules_test.c common.c
> +$(OUTPUT)/lockdown_test: lockdown_test.c common.c
> 
>  EXTRA_CLEAN = $(OUTPUT)/common.o
> diff --git a/tools/testing/selftests/lsm/common.c 
> b/tools/testing/selftests/lsm/common.c
> index 927dce4f04cb..e7d5cdb10137 100644
> --- a/tools/testing/selftests/lsm/common.c
> +++ b/tools/testing/selftests/lsm/common.c
> @@ -7,6 +7,7 @@
> 
>  #define _GNU_SOURCE
>  #include <linux/lsm.h>
> +#include <errno.h>
>  #include <fcntl.h>
>  #include <string.h>
>  #include <stdio.h>
> @@ -50,23 +51,39 @@ int read_proc_attr(const char *attr, char *value, 
> size_t size)
>  	return 0;
>  }
> 
> -int read_sysfs_lsms(char *lsms, size_t size)
> +int read_file(const char *path, char *buf, size_t size)
>  {
> -	FILE *fp;
> -	size_t red;
> +	ssize_t len;
> +	int fd;
> 
> -	fp = fopen("/sys/kernel/security/lsm", "r");
> -	if (fp == NULL)
> +	if (!size) {
> +		errno = EINVAL;
>  		return -1;
> -	red = fread(lsms, 1, size, fp);
> -	fclose(fp);
> +	}
> +
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0)
> +		return -1;
> +
> +	len = read(fd, buf, size - 1);
> +	if (len < 0) {
> +		int err = errno;
> 
> -	if (red <= 0 || red == size)
> +		close(fd);
> +		errno = err;
>  		return -1;
> -	lsms[red] = '\0';
> +	}
> +
> +	close(fd);
> +	buf[len] = '\0';
>  	return 0;
>  }
> 
> +int read_sysfs_lsms(char *lsms, size_t size)
> +{
> +	return read_file("/sys/kernel/security/lsm", lsms, size);
> +}
> +
>  int attr_lsm_count(void)
>  {
>  	char *names = calloc(sysconf(_SC_PAGESIZE), 1);
> diff --git a/tools/testing/selftests/lsm/common.h 
> b/tools/testing/selftests/lsm/common.h
> index 06d12110d241..2f824de2d1ad 100644
> --- a/tools/testing/selftests/lsm/common.h
> +++ b/tools/testing/selftests/lsm/common.h
> @@ -31,3 +31,5 @@ static inline int lsm_list_modules(__u64 *ids, __u32 
> *size, __u32 flags)
>  extern int read_proc_attr(const char *attr, char *value, size_t size);
>  extern int read_sysfs_lsms(char *lsms, size_t size);
>  int attr_lsm_count(void);
> +
> +extern int read_file(const char *path, char *buf, size_t size);
> diff --git a/tools/testing/selftests/lsm/lockdown_test.c 
> b/tools/testing/selftests/lsm/lockdown_test.c
> new file mode 100644
> index 000000000000..35109833da37
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/lockdown_test.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Linux Security Module infrastructure tests
> + * Tests for the lockdown securityfs interface
> + */
> +
> +#define _GNU_SOURCE
> +#include <linux/lsm.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include "kselftest_harness.h"
> +#include "common.h"
> +
> +#define LOCKDOWN_PATH "/sys/kernel/security/lockdown"
> +
> +static int write_status(const char *value)
> +{
> +	ssize_t len;
> +	int fd, err;
> +
> +	fd = open(LOCKDOWN_PATH, O_WRONLY);
> +	if (fd < 0)
> +		return -1;
> +
> +	len = write(fd, value, strlen(value));
> +	err = errno;
> +	close(fd);
> +	if (len < 0) {
> +		errno = err;
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int status_writable(void)
> +{
> +	int fd;
> +
> +	fd = open(LOCKDOWN_PATH, O_WRONLY);
> +	if (fd < 0)
> +		return -1;
> +
> +	close(fd);
> +	return 0;
> +}
> +
> +static int get_active_level(const char *buf, char *level, size_t size)
> +{
> +	const char *start, *end;
> +	size_t len;
> +
> +	start = strchr(buf, '[');
> +	if (!start)
> +		return -1;
> +	end = strchr(start, ']');
> +	if (!end)
> +		return -1;
> +
> +	len = end - start - 1;
> +	if (len == 0 || len >= size)
> +		return -1;
> +
> +	memcpy(level, start + 1, len);
> +	level[len] = '\0';
> +	return 0;
> +}
> +
> +TEST(lockdown_read_format)
> +{
> +	char buf[128], level[32];
> +
> +	if (read_file(LOCKDOWN_PATH, buf, sizeof(buf))) {
> +		if (errno == ENOENT)
> +			SKIP(return, "%s is not present", LOCKDOWN_PATH);
> +		SKIP(return, "cannot read %s: %s", LOCKDOWN_PATH,
> +		     strerror(errno));
> +	}
> +
> +	ASSERT_EQ(0, get_active_level(buf, level, sizeof(level)));
> +	ASSERT_TRUE(!strcmp(level, "none") ||
> +		    !strcmp(level, "integrity") ||
> +		    !strcmp(level, "confidentiality"));
> +
> +	ASSERT_NE(NULL, strstr(buf, "none"));
> +	ASSERT_NE(NULL, strstr(buf, "integrity"));
> +	ASSERT_NE(NULL, strstr(buf, "confidentiality"));
Those three tests should be moved above the active level tests.

> +}
> +
> +TEST(lockdown_invalid_write)
> +{
> +	char before[128], after[128];
> +
> +	if (read_file(LOCKDOWN_PATH, before, sizeof(before))) {
> +		if (errno == ENOENT)
> +			SKIP(return, "%s is not present", LOCKDOWN_PATH);
> +		SKIP(return, "cannot read %s: %s", LOCKDOWN_PATH,
> +		     strerror(errno));
> +	}
> +	if (geteuid() != 0)
> +		SKIP(return, "requires root");
> +	if (status_writable())
> +		SKIP(return, "cannot open %s for writing: %s",
> +		     LOCKDOWN_PATH, strerror(errno));
> +
> +	errno = 0;
> +	ASSERT_EQ(-1, write_status("invalid-level"));
> +	ASSERT_EQ(EINVAL, errno);
> +
> +	ASSERT_EQ(0, read_file(LOCKDOWN_PATH, after, sizeof(after)));
> +	ASSERT_STREQ(before, after);
> +}
> +
> +TEST(lockdown_no_downgrade)
> +{
> +	char before[128], after[128], level[32];
> +	const char *lower;
> +
> +	if (read_file(LOCKDOWN_PATH, before, sizeof(before))) {
> +		if (errno == ENOENT)
> +			SKIP(return, "%s is not present", LOCKDOWN_PATH);
> +		SKIP(return, "cannot read %s: %s", LOCKDOWN_PATH,
> +		     strerror(errno));
> +	}
> +	if (geteuid() != 0)
> +		SKIP(return, "requires root");
> +	if (status_writable())
> +		SKIP(return, "cannot open %s for writing: %s",
> +		     LOCKDOWN_PATH, strerror(errno));
> +	ASSERT_EQ(0, get_active_level(before, level, sizeof(level)));
> +
> +	if (!strcmp(level, "confidentiality"))
> +		lower = "integrity";
> +	else if (!strcmp(level, "integrity"))
> +		lower = "none";
> +	else
> +		SKIP(return, "kernel is not locked down, refusing to escalate");

The message is incorrect, it should state the opposite, you are trying
to downgrade Lockdown's level.

> +
> +	errno = 0;
> +	ASSERT_EQ(-1, write_status(lower));
> +	ASSERT_EQ(EPERM, errno);
> +
> +	ASSERT_EQ(0, read_file(LOCKDOWN_PATH, after, sizeof(after)));
> +	ASSERT_STREQ(before, after);
> +}
> +
> +TEST(lockdown_same_level_rejected)
> +{
> +	char before[128], after[128], level[32];
> +
> +	if (read_file(LOCKDOWN_PATH, before, sizeof(before))) {
> +		if (errno == ENOENT)
> +			SKIP(return, "%s is not present", LOCKDOWN_PATH);
> +		SKIP(return, "cannot read %s: %s", LOCKDOWN_PATH,
> +		     strerror(errno));
> +	}
> +	if (geteuid() != 0)
> +		SKIP(return, "requires root");
> +	if (status_writable())
> +		SKIP(return, "cannot open %s for writing: %s",
> +		     LOCKDOWN_PATH, strerror(errno));
> +	ASSERT_EQ(0, get_active_level(before, level, sizeof(level)));
> +
> +	errno = 0;
> +	ASSERT_EQ(-1, write_status(level));
> +	ASSERT_EQ(EPERM, errno);
> +
> +	ASSERT_EQ(0, read_file(LOCKDOWN_PATH, after, sizeof(after)));
> +	ASSERT_STREQ(before, after);
> +}
> +
> +TEST_HARNESS_MAIN

Since you are adding those tests, could you also add a test that checks
for Lockdown's level upgrading ?

Thanks,

Nicolas
