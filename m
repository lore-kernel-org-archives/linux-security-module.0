From: deepa.kernel@gmail.com (Deepa Dinamani)
Date: Fri,  7 Apr 2017 17:57:00 -0700
Subject: [PATCH 02/12] trace: Make trace_hwlat timestamp y2038 safe
In-Reply-To: <1491613030-11599-1-git-send-email-deepa.kernel@gmail.com>
References: <1491613030-11599-1-git-send-email-deepa.kernel@gmail.com>
Message-ID: <1491613030-11599-3-git-send-email-deepa.kernel@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

struct timespec is not y2038 safe on 32 bit machines
and needs to be replaced by struct timespec64
in order to represent times beyond year 2038 on such
machines.

Fix all the timestamp representation in struct trace_hwlat
and all the corresponding implementations.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 kernel/trace/trace_entries.h |  6 +++---
 kernel/trace/trace_hwlat.c   | 14 +++++++-------
 kernel/trace/trace_output.c  |  9 ++++-----
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index c203ac4..adcdbbe 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -348,14 +348,14 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
 		__field(	u64,			duration	)
 		__field(	u64,			outer_duration	)
 		__field(	u64,			nmi_total_ts	)
-		__field_struct( struct timespec,	timestamp	)
-		__field_desc(	long,	timestamp,	tv_sec		)
+		__field_struct( struct timespec64,	timestamp	)
+		__field_desc(	s64,	timestamp,	tv_sec		)
 		__field_desc(	long,	timestamp,	tv_nsec		)
 		__field(	unsigned int,		nmi_count	)
 		__field(	unsigned int,		seqnum		)
 	),
 
-	F_printk("cnt:%u\tts:%010lu.%010lu\tinner:%llu\touter:%llunmi-ts:%llu\tnmi-count:%u\n",
+	F_printk("cnt:%u\tts:%010llu.%010lu\tinner:%llu\touter:%llunmi-ts:%llu\tnmi-count:%u\n",
 		 __entry->seqnum,
 		 __entry->tv_sec,
 		 __entry->tv_nsec,
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 21ea6ae..d7c8e4e 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -79,12 +79,12 @@ static u64 last_tracing_thresh = DEFAULT_LAT_THRESHOLD * NSEC_PER_USEC;
 
 /* Individual latency samples are stored here when detected. */
 struct hwlat_sample {
-	u64		seqnum;		/* unique sequence */
-	u64		duration;	/* delta */
-	u64		outer_duration;	/* delta (outer loop) */
-	u64		nmi_total_ts;	/* Total time spent in NMIs */
-	struct timespec	timestamp;	/* wall time */
-	int		nmi_count;	/* # NMIs during this sample */
+	u64			seqnum;		/* unique sequence */
+	u64			duration;	/* delta */
+	u64			outer_duration;	/* delta (outer loop) */
+	u64			nmi_total_ts;	/* Total time spent in NMIs */
+	struct timespec64	timestamp;	/* wall time */
+	int			nmi_count;	/* # NMIs during this sample */
 };
 
 /* keep the global state somewhere. */
@@ -250,7 +250,7 @@ static int get_sample(void)
 		s.seqnum = hwlat_data.count;
 		s.duration = sample;
 		s.outer_duration = outer_sample;
-		s.timestamp = CURRENT_TIME;
+		ktime_get_real_ts64(&s.timestamp);
 		s.nmi_total_ts = nmi_total_ts;
 		s.nmi_count = nmi_count;
 		trace_hwlat_sample(&s);
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 02a4aeb..08f9bab 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2008 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
  *
  */
-
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/ftrace.h>
@@ -1161,11 +1160,11 @@ trace_hwlat_print(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, entry);
 
-	trace_seq_printf(s, "#%-5u inner/outer(us): %4llu/%-5llu ts:%ld.%09ld",
+	trace_seq_printf(s, "#%-5u inner/outer(us): %4llu/%-5llu ts:%lld.%09ld",
 			 field->seqnum,
 			 field->duration,
 			 field->outer_duration,
-			 field->timestamp.tv_sec,
+			 (long long)field->timestamp.tv_sec,
 			 field->timestamp.tv_nsec);
 
 	if (field->nmi_count) {
@@ -1195,10 +1194,10 @@ trace_hwlat_raw(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	trace_seq_printf(s, "%llu %lld %ld %09ld %u\n",
+	trace_seq_printf(s, "%llu %lld %lld %09ld %u\n",
 			 field->duration,
 			 field->outer_duration,
-			 field->timestamp.tv_sec,
+			 (long long)field->timestamp.tv_sec,
 			 field->timestamp.tv_nsec,
 			 field->seqnum);
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
