From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 06 Jun 2017 07:33:39 -0400
Subject: [Linux-ima-devel] [PATCH 5/7] ima: add securityfs interface to
	save a measurements list with kexec header
In-Reply-To: <25671f22-7145-6ff3-40c0-a27665443a2c@huawei.com>
References: <20170516125347.10574-1-roberto.sassu@huawei.com>
	<20170516125347.10574-6-roberto.sassu@huawei.com>
	<1496642698.2998.104.camel@linux.vnet.ibm.com>
	<25671f22-7145-6ff3-40c0-a27665443a2c@huawei.com>
Message-ID: <1496748819.5546.42.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-06-06 at 11:13 +0200, Roberto Sassu wrote:
> >>? /* returns pointer to hlist_node */
> >>? static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
> >>? {
> >>??????loff_t l = *pos;
> >>??????struct ima_queue_entry *qe;
> >> +????struct ima_queue_entry *qe_found = NULL;
> >> +????unsigned long size = 0, count = 0;
> >> +????bool khdr = m->file->f_path.dentry == binary_kexec_runtime_measurements;
> >>
> >>??????/* we need a lock since pos could point beyond last element */
> >>??????rcu_read_lock();
> >>??????list_for_each_entry_rcu(qe, &ima_measurements, later) {
> >> -????????????if (!l--) {
> >> -????????????????????rcu_read_unlock();
> >> -????????????????????return qe;
> >> +????????????if (!l) {
> >> +????????????????????qe_found = qe_found ? qe_found : qe;
> >
> > What is this?
> 
> ima_measurements_start() should return the list entry at position *pos.
> The line above prevents qe_found from being updated when the loop
> continues until the last list entry.

Wouldn't a simple if/then be more appropriate here?

> 
> >
> >> +
> >> +????????????????????if (!khdr)
> >> +????????????????????????????break;
> >
> > Does this test need to be in the loop?
> 
> Yes. Otherwise, ima_measurements_start() would iterate over the whole
> list when it is not necessary.

Oh, for displaying the measurement list you need to set qe_found
before returning.

thanks,

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
