From: boaz@plexistor.com (Boaz Harrosh)
Date: Wed, 10 May 2017 18:55:51 +0300
Subject: [PATCH] security/ima: use fs method to read integrity data
In-Reply-To: <20170510132359.GA22549@lst.de>
References: <20170510064507.1764-1-hch@lst.de>
	<20170510064507.1764-2-hch@lst.de>
	<a552827e-922d-0b28-2919-90c780a8a414@plexistor.com>
	<20170510132359.GA22549@lst.de>
Message-ID: <84bba69e-64a6-432d-bf27-54eb7669cea8@plexistor.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 05/10/2017 04:24 PM, Christoph Hellwig wrote:
> On Wed, May 10, 2017 at 03:20:41PM +0300, Boaz Harrosh wrote:
>> Would you not want to call ->read_iter() in the NULL case
>> and have all FSs supported as today?
> 
> As IMA has particular requirements on the fs (e.g. that it can
> read with i_rwsem held as seen in this patch, or useful i_version
> which only the file systems converted in this patch do), having
> an explicit opt-in seems much safer.  This optional method is
> a very easy way to provide this opt-in behavior.
> 

>> +	if (!file->f_op->integrity_read)
>> +		return -EBADF;
> 
> Would you not want to call ->read_iter() in the NULL case
> and have all FSs supported as today?
> 
> Thanks
> Boaz
> 
>>  
>> -	old_fs = get_fs();
>> -	set_fs(get_ds());
>> -	ret = __vfs_read(file, buf, count, &offset);
>> -	set_fs(old_fs);

If you look here above, it used to call __vfs_read regardless
of i_version and "opt-in" so it looks like a regression for
all those FSs that used to work.

So I did not understand, but I guess you are right opt-in seems much
safer.

Thanks
Boaz

>> +	init_sync_kiocb(&kiocb, file);
>> +	kiocb.ki_pos = offset;
>> +	iov_iter_init(&iter, READ | ITER_KVEC, &iov, 1, count);

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
