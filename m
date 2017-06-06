From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Tue, 06 Jun 2017 09:23:32 -0400
Subject: [PATCH 5/7] ima: add securityfs interface to save a
	measurements list with kexec header
In-Reply-To: <9b9e4d64-f08b-6c78-2e7d-9df9ac5d6969@huawei.com>
References: <20170516125347.10574-1-roberto.sassu@huawei.com>
	<20170516125347.10574-6-roberto.sassu@huawei.com>
	<1496642698.2998.104.camel@linux.vnet.ibm.com>
	<c4aa904b-052e-778d-caf9-47fbe8d961cb@huawei.com>
	<1496746591.5546.28.camel@linux.vnet.ibm.com>
	<9b9e4d64-f08b-6c78-2e7d-9df9ac5d6969@huawei.com>
Message-ID: <1496755412.5546.71.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2017-06-06 at 14:45 +0200, Roberto Sassu wrote:
> On 6/6/2017 12:56 PM, Mimi Zohar wrote:
> > On Tue, 2017-06-06 at 10:49 +0200, Roberto Sassu wrote:
> >> On 6/5/2017 8:04 AM, Mimi Zohar wrote:
> >>> On Tue, 2017-05-16 at 14:53 +0200, Roberto Sassu wrote:
> >>>> Through the new interface binary_kexec_runtime_measurements, it will be
> >>>> possible to read the same content returned by binary_runtime_measurements,
> >>>> with the kexec header prepended.
> >>>>
> >>>> The new interface has been added for testing ima_restore_measurement_list()
> >>>> which, at the moment, works only on PPC systems. The interface for reading
> >>>> the binary list with the kexec header will be provided in a separate patch.
> >>>>
> >>>> The patch reuses ima_measurements_start() and ima_measurements_next()
> >>>> to send the measurements list to userspace. Their behavior changes
> >>>> depending on the current dentry.
> >>>>
> >>>> To provide the correct information in the kexec header,
> >>>> ima_measurements_start() has to iterate over the whole list and calculate
> >>>> the number of entries and the total size. It is not possible to read
> >>>> the value of the global variable binary_runtime_size and ima_htable.len
> >>>> without taking ima_extend_list_mutex, because there might have been a list
> >>>> add between the two read operations.
> >>>
> >>> Please correct me if I'm wrong.  Your code walks the measurement list
> >>> calculating the total number of measurements and the memory size
> >>> needed to store in the kexec header.  Can't there be additional
> >>> measurements between the time these values - total number of
> >>> measurements and memory needed - were calculated and actually saving
> >>> the measurements?  How would that be any different than the problem
> >>> you're trying to solve?  In both cases, the number of measurements
> >>> might be less than the actual number of measurements.
> >>>
> >>> As long as you query the number of measurements before getting the
> >>> memory needed, unless you're trying to verify a TPM quote, having
> >>> fewer measurements shouldn't be a problem for testing.
> >>
> >> The problem is that the total number of entries and the required
> >> memory size might be inconsistent without taking ima_extend_list_mutex.
> >> ima_measurements_start() could read the entries counter before
> >> it is incremented by ima_add_digest_entry() and the required memory
> >> size after it is updated. If this happens, the parser returns an error
> >> because ENFORCE_BUFEND is set for the last entry and there would be
> >> still data to read (the new entry added to the list).
> >
> > I don't see this as being any different than what happens when the
> > kernel saves the measurement list. Originally, the memory size was
> > defined at kexec load, but only populated at kexec execute.  There was
> > plenty of time between the kexec load and execute for additional
> > measurement records to be added.
> >
> > The upstreamed version defines the buffer size and populates it at
> > kexec load.  However kexec load itself generates additional
> > measurements, so it has to reserve more memory than what is returned
> > by ima_get_binary_runtime_size(). (Refer to ima_add_kexec_buffer.)
> 
> ima_dump_measurement_list() determines the total number of entries and
> the required memory size (which are written to the kexec header) after
> iterating over the whole list. Are new entries added to the kexec buffer
> after ima_dump_measurement_list() is called?

The upstreamed version allocates the segment in kexec load and then
fills the buffer. ?However, in between getting the current memory size
needed and filling the buffer, additional measurements can be added.
Thus the segment size needs to be larger than the current memory
size.?

The header reflects the number of measurements and the actual buffer
size, not the segment size. ?When restoring the measurement list,
however, we rely on the number of measurements and use the buffer size
as a reference to prevent accessing memory beyond the buffer. ?The
buffer size does not need to be exact.

** Note **
This upstream version, which doesn't update the measurement list in
kexec execute, requires all files to be pre-measured, before calling
kexec load. ?Otherwise, the measurement list will not validate against
the quoted TPM PCRs.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
