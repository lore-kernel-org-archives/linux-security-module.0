From: kim.phillips@arm.com (Kim Phillips)
Date: Thu, 17 Aug 2017 22:09:41 -0500
Subject: [PATCH 06/27] Provide supplementary error message facility [ver
	#5]
In-Reply-To: <149745337097.10897.6533194783327792549.stgit@warthog.procyon.org.uk>
References: <149745330648.10897.9605870130502083184.stgit@warthog.procyon.org.uk>
	<149745337097.10897.6533194783327792549.stgit@warthog.procyon.org.uk>
Message-ID: <20170817220941.8c6532b076bb0d8db60a6968@arm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 14 Jun 2017 16:16:11 +0100
David Howells <dhowells@redhat.com> wrote:

> Provide a way for the kernel to pass supplementary error messages to
> userspace.  This will make it easier for userspace, particularly in
> containers to find out what went wrong during mounts and automounts, but is
> also made available to any other syscalls that want to use it.

Hi all, I see patches 1-5 have already made it to Linus' master branch,
but I can't determine the status of this particular patch.

Assuming it's still under consideration, I'd like to attest to the
significantly higher level of user experience improvement it can give
perf users (see RFC below):  Am I taking the right approach here by
assuming this new error message facility is indeed eligible for upstream
acceptance sometime soon?

Thanks,

Kim

>From da34ddaf1aa8c731f645c268a1caf17029caca8c Mon Sep 17 00:00:00 2001
From: Kim Phillips <kim.phillips@arm.com>
Date: Wed, 16 Aug 2017 17:56:40 -0500
Subject: [RFC] perf tool & spe driver: shot at prctl errmsging

Example session: Lines beginning with "spe-pmu@" are new and
specify what the PMU driver found wrong to the user in a much
more precise manner:

$ ./perf record -e arm_spe_0// -C 0-3 true
Error:
spe-pmu at 0: no sample period, or less than minimum (256)
PMU Hardware doesn't support sampling/overflow-interrupts.
$ ./perf record -e arm_spe_0// -C 0-3 -c 1024 true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.022 MB perf.data ]
$ ./perf record -e arm_spe_0// -C 0-4 -c 1024 true
Error:
spe-pmu at 0: not supported on CPU 4. Supported CPU list: 0-3
The arm_spe_0// event is not supported.
$ ./perf record -e arm_spe_0/pa_enable=1/ -C 0-3 -c 1024 true
Error:
spe-pmu at 0: physical address and/or context ID capture limited to privileged users
$ sudo ./perf record -e arm_spe_0/pa_enable=1/ -C 0-3 -c 1024 true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.071 MB perf.data ]
$

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
---
- patch available and rebased on top of linux-will.git/perf/spe's latest, here:
	http://www.linux-arm.org/git?p=linux-kp.git;a=shortlog;h=refs/heads/spe-prctl
  or
	git://linux-arm.org/linux-kp.git  # spe-prctl branch

 drivers/perf/arm_spe_pmu.c | 46 ++++++++++++++++++++++++++++++++++++++--------
 tools/perf/perf.c          | 12 ++++++++++++
 tools/perf/util/evsel.c    | 14 +++++++++-----
 3 files changed, 59 insertions(+), 13 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index fef0a4834879..cb4db7dac929 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -23,11 +23,13 @@
 #define DRVNAME				PMUNAME "_pmu"
 #define pr_fmt(fmt)			DRVNAME ": " fmt
 
+#include <linux/cpumask.h>
 #include <linux/cpuhotplug.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/device.h>
 #include <linux/of_device.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
@@ -660,20 +662,30 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	u64 reg;
 	struct perf_event_attr *attr = &event->attr;
 	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
+	const struct device *dev = &spe_pmu->pdev->dev;
+	const char *devname = dev_name(dev);
 
 	/* This is, of course, deeply driver-specific */
 	if (attr->type != event->pmu->type)
 		return -ENOENT;
 
 	if (event->cpu >= 0 &&
-	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
+	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus)) {
+		errorf("%s: not supported on CPU %d. Supported CPU list: %*pbl\n",
+		       devname, event->cpu, cpumask_pr_args(&spe_pmu->supported_cpus));
 		return -ENOENT;
+	}
 
-	if (arm_spe_event_to_pmsevfr(event) & PMSEVFR_EL1_RES0)
+	if (arm_spe_event_to_pmsevfr(event) & PMSEVFR_EL1_RES0) {
+		errorf("%s: unsupported Sampling Event Filter (PMSEVFR) value\n",
+		       devname);
 		return -EOPNOTSUPP;
+	}
 
-	if (attr->exclude_idle)
+	if (attr->exclude_idle) {
+		errorf("%s: Cannot exclude profiling when idle\n", devname);
 		return -EOPNOTSUPP;
+	}
 
 	/*
 	 * Feedback-directed frequency throttling doesn't work when we
@@ -682,26 +694,44 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	 * count to reflect that. Instead, force the user to specify a
 	 * sample period instead.
 	 */
-	if (attr->freq)
+	if (attr->freq) {
+		errorf("%s: sample period must be specified\n", devname);
 		return -EINVAL;
+	}
+
+	if (!event->hw.sample_period ||
+	    event->hw.sample_period < spe_pmu->min_period) {
+		errorf("%s: no sample period, or less than minimum (%d)\n",
+		       devname, spe_pmu->min_period);
+		return -EOPNOTSUPP;
+	}
 
 	reg = arm_spe_event_to_pmsfcr(event);
 	if ((reg & BIT(PMSFCR_EL1_FE_SHIFT)) &&
-	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_EVT))
+	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_EVT)) {
+		errorf("%s: unsupported filter (EVT)\n", devname);
 		return -EOPNOTSUPP;
+	}
 
 	if ((reg & BIT(PMSFCR_EL1_FT_SHIFT)) &&
-	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_TYP))
+	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_TYP)) {
+		errorf("%s: unsupported filter (TYP)\n", devname);
 		return -EOPNOTSUPP;
+	}
 
 	if ((reg & BIT(PMSFCR_EL1_FL_SHIFT)) &&
-	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
+	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT)) {
+		errorf("%s: unsupported filter (LAT)\n", devname);
 		return -EOPNOTSUPP;
+	}
 
 	reg = arm_spe_event_to_pmscr(event);
 	if (!capable(CAP_SYS_ADMIN) &&
-	    (reg & (BIT(PMSCR_EL1_PA_SHIFT) | BIT(PMSCR_EL1_CX_SHIFT))))
+	    (reg & (BIT(PMSCR_EL1_PA_SHIFT) | BIT(PMSCR_EL1_CX_SHIFT)))) {
+		errorf("%s: physical address and/or context ID capture limited to privileged users\n",
+		       devname);
 		return -EACCES;
+	}
 
 	return 0;
 }
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 628a5e412cb1..0d16dc5042ab 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -30,6 +30,13 @@
 #include <unistd.h>
 #include <linux/kernel.h>
 
+#include <fcntl.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+
+#define PR_ERRMSG_ENABLE		48
+#define PR_ERRMSG_READ			49
+
 const char perf_usage_string[] =
 	"perf [--version] [--help] [OPTIONS] COMMAND [ARGS]";
 
@@ -431,6 +438,11 @@ int main(int argc, const char **argv)
 	char sbuf[STRERR_BUFSIZE];
 	int value;
 
+	if (prctl(PR_ERRMSG_ENABLE, 1) < 0) {
+		perror("prctl/en");
+		exit(1);
+	}
+
 	/* libsubcmd init */
 	exec_cmd_init("perf", PREFIX, PERF_EXEC_PATH, EXEC_PATH_ENVIRONMENT);
 	pager_init(PERF_PAGER_ENVIRONMENT);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d9899280a9ee..e997a361d1eb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -21,6 +21,7 @@
 #include <sys/ioctl.h>
 #include <sys/resource.h>
 #include <sys/types.h>
+#include <sys/prctl.h>
 #include <dirent.h>
 #include "asm/bug.h"
 #include "callchain.h"
@@ -40,6 +41,9 @@
 
 #include "sane_ctype.h"
 
+#define PR_ERRMSG_ENABLE		48
+#define PR_ERRMSG_READ			49
+
 static struct {
 	bool sample_id_all;
 	bool exclude_guest;
@@ -2518,19 +2522,19 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 			      int err, char *msg, size_t size)
 {
 	char sbuf[STRERR_BUFSIZE];
-	int printed = 0;
-	int n, perr;
+	int perr, printed = 0;
+	size_t n;
 
 	do {
 		errno = 0;
 		n = prctl(PR_ERRMSG_READ, sbuf, sizeof(sbuf));
 		perr = errno;
-		if (n > 0) {
-			printed = scnprintf(msg, n + 1, "%s\n", sbuf);
+		if (n > 0 && n < size) {
+			sbuf[n] = 0;
+			printed = scnprintf(msg, size, "%s", sbuf);
 			size -= printed;
 			msg += printed;
 		}
-		
 	} while (perr == 0);
 
 	switch (err) {
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info@ http://vger.kernel.org/majordomo-info.html
