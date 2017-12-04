From: dmitry.kasatkin@huawei.com (Dmitry Kasatkin)
Date: Mon, 4 Dec 2017 17:40:45 +0200
Subject: [PATCHv5 1/1] ima: re-introduce own integrity cache lock
In-Reply-To: <37b6f8d7-69a8-8900-e7b6-a614b64f91dd@huawei.com>
References: <fe908aedea9e8a03789bfaace514b5b10f20b301.1512153609.git.dmitry.kasatkin@huawei.com>
	<1512389173.3977.26.camel@linux.vnet.ibm.com>
	<37b6f8d7-69a8-8900-e7b6-a614b64f91dd@huawei.com>
Message-ID: <82f4e192-446f-75fd-5374-3db6aeaf83f6@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 04/12/17 15:42, Roberto Sassu wrote:
> On 12/4/2017 1:06 PM, Mimi Zohar wrote:
>> Hi Dmitry,
>>
>> On Fri, 2017-12-01 at 20:40 +0200, Dmitry Kasatkin wrote:
>>> The original design was discussed 3+ years ago, but was never 
>>> completed/upstreamed.
>>> Based on the recent discussions with Linus
>>> https://patchwork.kernel.org/patch/9975919, I've rebased this patch.
>>>
>>> Before IMA appraisal was introduced, IMA was using own integrity cache
>>> lock along with i_mutex. process_measurement and ima_file_free took
>>> the iint->mutex first and then the i_mutex, while setxattr, chmod and
>>> chown took the locks in reverse order. To resolve the potential 
>>> deadlock,
>>> i_mutex was moved to protect entire IMA functionality and the redundant
>>> iint->mutex was eliminated.
>>>
>>> Solution was based on the assumption that filesystem code does not take
>>> i_mutex further. But when file is opened with O_DIRECT flag, direct-io
>>> implementation takes i_mutex and produces deadlock. Furthermore, certain
>>> other filesystem operations, such as llseek, also take i_mutex.
>>>
>>> More recently some filesystems have replaced their filesystem specific
>>> lock with the global i_rwsem to read a file.? As a result, when IMA
>>> attempts to calculate the file hash, reading the file attempts to take
>>> the i_rwsem again.
>>>
>>> To resolve O_DIRECT related deadlock problem, this patch re-introduces
>>> iint->mutex. But to eliminate the original chmod() related deadlock
>>> problem, this patch eliminates the requirement for chmod hooks to take
>>> the iint->mutex by introducing additional atomic iint->attr_flags to
>>> indicate calling of the hooks. The allowed locking order is to take
>>> the iint->mutex first and then the i_rwsem.
>>>
>>> Original flags were cleared in chmod(), setxattr() or removwxattr() 
>>> hooks
>>> and tested when file was closed or opened again. New atomic flags are 
>>> set
>>> or cleared in those hooks and tested to clear iint->flags on close or 
>>> on open.
>>>
>>> Atomic flags are following:
>>> * IMA_CHANGE_ATTR - indicates that chATTR() was called (chmod, chown, 
>>> chgrp)
>>> ?? and file attributes have changed. On file open, it causes IMA to 
>>> clear
>>> ?? iint->flags to re-evaluate policy and perform IMA functions again.
>>> * IMA_CHANGE_XATTR - indicates that setxattr or removexattr was 
>>> called and
>>> ?? extended attributes have changed. On file open, it causes IMA to 
>>> clear
>>> ?? iint->flags IMA_DONE_MASK to re-appraise.
>>> * IMA_UPDATE_XATTR - indicates that security.ima needs to be updated.
>>> ?? It is cleared if file policy changes and no update is needed.
>>> * IMA_DIGSIG - indicates that file security.ima has signature and file
>>> ?? security.ima must not update to file has on file close.
>>
>> Nice! ?I've been testing with this patch and all seems good. ?Before
>> queueing this patch to be upstreamed, I'd appreciate if others tested
>> using it as well. ?It applies cleanly to the next-queued branch.
> 
> If the inode lock is released before the IMA_MEASURE flag is set, the
> ToMToU violation will not be detected when a writer accesses the same
> inode. This issue was fixed with commit f7a859ff7395c.
> 
> Roberto

Hi Roberto,

I will check the commit.

Dmitry

> 
> 
>> A subsequent patch will remove the O_DIRECT check in
>> ima_calc_file_hash().
>>
>> Fixes: Commit 6552321831dc "xfs: remove i_iolock and use i_rwsem in
>> the VFS inode instead"
>>
>> thanks,
>>
>> Mimi
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-security-module" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at? http://vger.kernel.org/majordomo-info.html
>>
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
